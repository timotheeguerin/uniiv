class CourseGradingSystemEntity < ActiveRecord::Base
  belongs_to :sys, :class_name => 'CourseGradingSystem'
end
