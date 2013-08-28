class Course::Scenario < ActiveRecord::Base
  belongs_to :user, :class_name => User
  has_many :taking_courses, :class_name => UserTakingCourse, :foreign_key => 'course_scenario_id'
  has_many :courses, :through => :taking_courses

  has_and_belongs_to_many :programs

  def find_by_course(course)
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
end
