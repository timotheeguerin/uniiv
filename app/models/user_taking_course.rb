class UserTakingCourse < ActiveRecord::Base
  belongs_to :course_scenario, :class_name => Course::Scenario
  belongs_to :course, :class_name => Course::Course
  belongs_to :semester, :class_name => Course::Semester
  belongs_to :grade, :class_name => Course::GradingSystemEntity

  accepts_nested_attributes_for :semester
  accepts_nested_attributes_for :grade

  validates_uniqueness_of :course_id, :scope => [:course_scenario]

  def user
    course_scenario.user
  end

  def to_s
    user.to_s + ' - ' + course.to_s + ' ' + semester.to_s
  end

end
