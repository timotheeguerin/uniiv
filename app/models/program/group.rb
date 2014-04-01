class Program::Group < ActiveRecord::Base

  belongs_to :groupparent, :polymorphic => true

  has_many :subgroups, :class_name => Program::Group, :as => :groupparent

  #List of courses to complete
  has_and_belongs_to_many :list_courses, -> { uniq }, :class_name => Course::Course

  #List of the subject_courses
  has_many :subject_courses, :class_name => Course::SubjectCourseList

  has_many :restrictions, :class_name => Program::GroupRestriction, :dependent => :destroy

  #Complete a number of programs
  has_and_belongs_to_many :programs, -> { uniq }, :class_name => Program::Program

  validates_presence_of :groupparent_id

  def courses
    result = list_courses
    subject_courses.each do |subject_course|
      result += subject_course.courses
    end
    result
  end

  def to_s
    name.to_s + " (#{type.to_s})"
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
    elsif groupparent.instance_of?(Program::Program)
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
    return  {:ratio => 1, :coefficient => 0, :value => 1}
    if restrictions.size == 0
      Utils::Ratio.empty
    else
      ratio = Utils::Ratio.empty
      restrictions.each do |restriction|

      end
      ratio
    end
    restriction = restrictions.first
    if restriction.nil?
      {:ratio => 0, :coefficient => 1, :value => 0}
    else
      case restriction.type.name
        when 'min_credit'
          puts 'MIN CREDIT'
          completed_credit = count_credit_completed_courses(scenario, term)
          subgroup_completed = get_subgroups_completed_ratio(scenario)
          puts 'Sub group completed: ' + subgroup_completed.to_s
          return {:ratio => 0, :coefficient => 1, :value => 0} if restriction.value == 0 and subgroup_completed[:coefficient] == 0
          ratio = (completed_credit + subgroup_completed[:value])/ (restriction.value + subgroup_completed[:coefficient])
          ratio = 1 if ratio > 1
          puts 'VALUE: ' + restriction.value.to_s
          {:ratio => ratio, :coefficient => restriction.value, :value => restriction.value*ratio}
        when 'min_grp'
          {:ratio => 1, :coefficient => 1, :value => 1}
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

  end

  def get_coefficient
    restriction = restrictions.first
    case restriction.type.name
      when 'min_credit'
    restriction.value
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
      result = result.where do
        id.in(scenario.taking_courses.pluck(:course_id)) if options[:only_taking] and
            id.in(scenario.user.completed_courses.pluck(:course_id)) if options[:only_completed] and
            id.not_in(scenario.taking_courses.pluck(:course_id)) if options[:only_not_taking] and
            id.not_in(scenario.user.completed_courses.pluck(:course_id)) if options[:only_not_completed]
      end
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
      term = Utils::Term::last_allowed
    end
    get_completion_ratio(scenario, term) == 1
  end

  def id_to_s
    'g_' + id.to_s
  end

  searchable do
    text :program do
      parent_program.name unless parent_program.nil?
    end
    text :name
  end
end