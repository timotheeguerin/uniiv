class Course::GradingSystem < ActiveRecord::Base
  has_many :entities, :class_name => Course::GradingSystemEntity, :foreign_key => "system_id"

  def to_s
    name
  end
  
end
