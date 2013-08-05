class UserCompletedCourse < ActiveRecord::Base
  belongs_to :user, :class_name => User
  belongs_to :course, :class_name => Course
  belongs_to :grade, :class_name => CourseGradingSystemEntity
end
