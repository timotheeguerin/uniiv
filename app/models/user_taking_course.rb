class UserTakingCourse < ActiveRecord::Base
  belongs_to :user, :class_name => User
  belongs_to :course, :class_name => Course::Course

  def to_s
    user.to_s + " - " + course.to_s
  end
  
end
