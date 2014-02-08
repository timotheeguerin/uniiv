class Admin::CourseRequirementFilled < ActiveRecord::Base
  belongs_to :course, :class_name => Course::Course

  validates_uniqueness_of :course_id
  def to_s
    "r: #{prerequisites} - c: #{corequisites}"
  end
end
