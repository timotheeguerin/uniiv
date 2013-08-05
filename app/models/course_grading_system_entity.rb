class CourseGradingSystemEntity < ActiveRecord::Base
  belongs_to :system, :class_name => CourseGradingSystem
end
