class Admin::CourseRequirementFilled < ActiveRecord::Base
  belongs_to :course, :class_name => Course::Course
  def to_s
    "r: #{prerequisites} - c: #{corequisites}"
  end
end
