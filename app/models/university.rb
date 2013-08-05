class University < ActiveRecord::Base
	belongs_to :grading_system, :class_name => CourseGradingSystem
	has_many :faculties, :class_name => Faculty

  def to_s
    name
  end
end
