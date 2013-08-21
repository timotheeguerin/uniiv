class UserTakingCourse < ActiveRecord::Base
  belongs_to :user, :class_name => User
  belongs_to :course, :class_name => Course::Course
  belongs_to :semester, :class_name => Course::Semester

  def to_s
    user.to_s + ' - ' + course.to_s + ' ' + semester.to_s
  end

end
