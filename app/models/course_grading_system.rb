class CourseGradingSystem < ActiveRecord::Base
  has_many entities, :class_name => CourseGradingSystemEntity
end
