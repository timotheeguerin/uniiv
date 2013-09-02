class Course::Scenario < ActiveRecord::Base
  belongs_to :user, :class_name => User
  has_many :taking_courses, :class_name => UserTakingCourse, :foreign_key => 'course_scenario_id'
  has_many :courses, :through => :taking_courses

  has_and_belongs_to_many :programs


  def has_completed_course?(course, inc_advanced_standing = true, term = nil)
    if term.nil?
      user.has_completed_course?(course, inc_advanced_standing)
    else
      user.has_completed_course?(course, inc_advanced_standing) or will_course_be_completed(course, term)
    end
  end

  def is_taking_course?(course, term = nil?)
    term ||= Term::now
    taking_courses.each do |c|
      if c.course == course and c.year == term.year and c.semester == term.semester
        return true
      end
    end
    false
  end

  def plan_to_take_course(course)
    taking_courses.where(:course_id => course).size >0
  end

  def requirements_completed?(course, term = nil)
    course.requirements_completed?(self, term)
  end

  #Return if the user is taking courses at the wrong time
  def has_errors?
    taking_courses.each do |course|
      unless course.is_time_valid?
        return true
      end
    end
    false
  end

  #Check if a course is going to be completed in the given term
  def will_course_be_completed(course, term)
    taking_course = taking_courses.where(:course_id => course).first
    if taking_course.nil?
      false
    else
      taking_course.year < term.year or (taking_course.year <= term.year and taking_course.semester.order < term.semester.order)
    end
  end

  def get_by_course(course)
    taking_courses.where(:course_id => course).first
  end


  def get_course_in_semester(semester, year)
    taking_courses.where(:semester_id => semester, :year => year)
  end

  def get_course_later_than(semester, year)
    taking_courses.joins(:semester).where('(course_semesters.order > :order AND year = :year) OR year > :year',
                                          :order => semester.order, :year => year)
  end

  def get_course_before_than(s, y)
    order = s.order
    taking_courses.joins(:semester).where { ((semester.order < order) & (year == y)) | (year < y) }
  end

  #Check if the scenario is taking the course
  def is_taking?(course)
    courses.include?(course)
  end

  alias :can_take_course? :requirements_completed?
end
