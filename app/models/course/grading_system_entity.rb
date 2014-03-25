class Course::GradingSystemEntity < ActiveRecord::Base
  belongs_to :grading_system, :class_name => Course::GradingSystem
  def to_s
    name
  end

end
