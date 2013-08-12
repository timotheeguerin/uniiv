class Course::GradingSystemEntity < ActiveRecord::Base
  belongs_to :sys, :class_name => Course::GradingSystem
  
  def to_s
    return name
  end
  
end
