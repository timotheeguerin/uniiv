class Course::GradingSystemEntity < ActiveRecord::Base
  belongs_to :sys, :class_name => Course::GradingSystem

  def to_s
    name
  end

end
