class ProgramGroup < ActiveRecord::Base

  belongs_to :restriction, :class_name => ProgramGroupRestriction
  belongs_to :groupparent, :polymorphic => true
  has_many :subgroups, :class_name => ProgramGroup, :as => :groupparent
  has_and_belongs_to_many :courses, :class_name => Course::Course

  #Complete a number of programs
  has_and_belongs_to_many :programs, :class_name => Program


  def to_s
    name
  end

  def type
    if groupparent.nil?
      ''
    else
      groupparent.type
    end
  end

  def parent_program
    if groupparent.nil?
      nil
    elsif groupparent.instance_of?(Program)
      groupparent
    else
      groupparent.parent_program
    end
  end


  def get_requirement_level
    complexity = 0
    courses.each do |course|
      complexity += course.count_requirements
    end
    subgroups.each do |subgroup|
      complexity += subgroup.get_requirement_level
    end
    complexity
  end

  def get_subgroups_completed_ratio(scenario, term = nil)
    ratio = 0
    coefficient = 0
    subgroups.each do |subgroup|
      coef = subgroup.get_coefficient

      ratio += (subgroup.get_completion_ratio(scenario, term)[:value])
      coefficient += coef
    end
    return {:ratio => 0, :coefficient => 0, :value => 0} if coefficient == 0
    {:ratio => ratio/coefficient.to_f, :coefficient => coefficient, :value => ratio}
  end

  def get_subgroups_coef
    coefficient = 0
    subgroups.each do |subgroup|
      coefficient += subgroup.get_coefficient
    end
    coefficient
  end

  def count_completed_courses(scenario, term= nil)
    count = 0
    courses.each do |course|
      count += 1 if scenario.has_completed_course?(course, term)
    end
    count
  end

  def count_credit_completed_courses(scenario, term = nil)
    count = 0
    courses.each do |course|
      count += course.credit if scenario.has_completed_course?(course, true, term)
    end
    subgroups.each do |subgroup|
      count += subgroup.count_credit_completed_courses(scenario, term)
    end
    count
  end

  def count_total_credit
    count = 0
    courses.each do |course|
      count += course.credit
    end
    count
  end

  def get_completion_ratio(scenario, term = nil)
    case restriction.name
      when 'min_credit'
        completed_credit = count_credit_completed_courses(scenario, term)
        subgroup_completed = get_subgroups_completed_ratio(scenario)
        return 1 if value == 0 and subgroup_completed[:coefficient] == 0


        ratio = (completed_credit + subgroup_completed[:value])/ (value + subgroup_completed[:coefficient])
        ratio = 1 if ratio > 1
        {:ratio => ratio, :coefficient => value, :value => value*ratio}
      when 'min_grp'
        return {:ratio => 1, :coefficient => 1, :value => 1}
      else
        if courses.size != 0
          coef = courses.size.to_f
          value = count_completed_courses(scenario, term)
          return {:ratio => value/ coef, :coefficient => coef, :value => value}
        else
          return {:ratio => 1, :coefficient => 0, :value => 1}
        end
    end
  end

  def get_coefficient
    case restriction.name
      when 'min_credit'
        value
      when 'min_grp'
        return 1
      else
        count_total_credit
    end
  end

  def get_all_courses(options={})
    result = []
    default_options={
        :only_taking => false,
        :only_not_taking => false,
        :only_completed => false,
        :only_not_completed => false
    }
    options = options.reverse_merge(default_options)
    scenario = options[:scenario]
    result = courses
    unless scenario.nil?
      result = result.where { id.in(scenario.taking_courses.pluck(:course_id)) } if options[:only_taking]
      result = result.where { id.not_in(scenario.taking_courses.pluck(:course_id)) } if options[:only_not_taking]
    end
    result
  end

  def completed?(scenario, options = {})
    default_options = {
        :planning => false #Check also using the course the user is taking
    }
    options = default_options.merge(options)
    term = nil

    if options[:planning]
      term = Term::last_allowed
    end
    get_completion_ratio(scenario, term) == 1
  end

  def id_to_s
    'g_' + id.to_s
  end
end