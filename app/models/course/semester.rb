class Course::Semester < ActiveRecord::Base
  has_many :courses_taking, :class_name => UserTakingCourse
  has_many :courses_completed, :class_name => UserCompletedCourse

  def to_s
    name.to_s
  end
end
