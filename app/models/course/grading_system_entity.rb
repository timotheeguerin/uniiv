class Course::GradingSystemEntity < ActiveRecord::Base
  belongs_to :sys, :class_name => Course::GradingSystem
end
