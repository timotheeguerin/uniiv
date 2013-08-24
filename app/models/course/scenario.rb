class Course::Scenario < ActiveRecord::Base
  belongs_to :user, :class_name => User
  has_many :taking_courses, :class_name => UserTakingCourse, :foreign_key => 'course_scenario_id'

  def find_by_course(course)
    taking_courses.where(:course => course).first
  end


  def get_course_in_semester(semester, year)
    taking_courses.where(:semester => semester, :year => year)
  end

  def get_course_later_than(semester, year)
    taking_courses.joins(:semester).where('(course_semesters.order > :order AND year = :year) OR year > :year',
                                          :order => semester.order, :year => year)
  end

  def get_course_before_than(semester, year)
    taking_courses.joins(:semester).where('(course_semesters.order < :order AND year = :year) OR year < :year',
                                          :order => semester.order, :year => year)
  end
end
