class Course::GradingSystem < ActiveRecord::Base
  has_many :entities, :class_name => Course::GradingSystemEntity

  def to_s
    name
  end

end
