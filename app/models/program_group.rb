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
    count
  end

  def get_completion_ratio(user)
    puts 'RESTRIC: ' + restriction.name
    case restriction.name
      when 'min_credit'
        completed_credit = count_credit_completed_courses(user)
        if completed_credit < value
          return completed_credit / value
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


  def id_to_s
    'g_' + id.to_s
  end
end