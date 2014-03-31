class Course::Subject < ActiveRecord::Base
  belongs_to :university, :class_name => University
  has_many :courses, :class_name => Course::Course

  def to_s
    name
  end

end
