class UsersCoursesRecommendation < ActiveRecord::Base
  belongs_to :user, :class_name => User
  belongs_to :course, :class_name => Course::Course
  belongs_to :type, :class_name => UsersCoursesRecommendationType

  validates_uniqueness_of :course_id, :scope => :user_id
end
