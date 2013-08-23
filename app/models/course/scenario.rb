class Course::Scenario < ActiveRecord::Base
  belongs_to :user, :class_name => User
  has_many :taking_courses, :class_name => UserTakingCourse, :foreign_key => 'course_scenario_id'

  def find_by_course(course)
    taking_courses.where(:course => course).first
  end
end
