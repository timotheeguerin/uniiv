class CourseGradingSystem < ActiveRecord::Base
	has_many :entities, :class_name => CourseGradingSystemEntity,  :foreign_key => "system_id"
end
