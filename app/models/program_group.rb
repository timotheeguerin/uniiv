class ProgramGroup < ActiveRecord::Base

  belongs_to :restriction, :class_name => ProgramGroupRestriction
  belongs_to :groupparent, :polymorphic => true
  has_many :subgroups, :class_name => ProgramGroup, :as => :groupparent
  has_and_belongs_to_many :courses, :class_name => Course::Course

  #Complete a number of programs
  has_and_belongs_to_many :programs, :class_name => Program


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

  def get_subgroups_completed_ratio(user)
    ratio = 0
    coefficient = 0
    subgroups.each do |subgroup|
      coef = subgroup.get_coefficient
      ratio += subgroup.get_completion_ratio(user) * coef
      coefficient += coef
    end
    return 0 if coefficient == 0
    ratio/coefficient.to_f
  end

  def get_subgroups_coef
    coefficient = 0
    subgroups.each do |subgroup|
      coefficient += subgroup.get_coefficient
    end
    coefficient
  end

  def count_completed_courses(user)
    count = 0
    courses.each do |course|
      count += 1 if user.has_completed_course?(course)
    end
    count
  end

  def count_credit_completed_courses(user)
    count = 0
    courses.each do |course|
      count += course.credit if user.has_completed_course?(course)
    end
    subgroups.each do |subgroup|
      count += subgroup.count_credit_completed_courses(user)
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

  def get_completion_ratio(user)
    case restriction.name
      when 'min_credit'
        completed_credit = count_credit_completed_courses(user)
        subgroup_completed = get_subgroups_completed_ratio(user)
        subgroup_coef = get_subgroups_coef

        ratio = (completed_credit + subgroup_completed*subgroup_coef)/ (value + subgroup_coef)
        if ratio < 1
          return ratio
        else
          return 1
        end
      when 'min_grp'
        return 1
      else
        if courses.size != 0
          return (count_completed_courses(user) / courses.size.to_f)
        else
          return 1
        end
    end
  end

  def get_coefficient()
    case restriction.name
      when 'min_credit'
        value
      when 'min_grp'
        return 1
      else
        count_total_credit
    end
  end

  def id_to_s
    'g_' + id.to_s
  end
end