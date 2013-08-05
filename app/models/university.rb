class University < ActiveRecord::Base
	belongs_to :grading_system, :class_name => CourseGradingSystem
end
