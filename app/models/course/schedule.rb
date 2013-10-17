class Course::Schedule < ActiveRecord::Base
  belongs_to :semester, :class_name => Course::Semester
  belongs_to :course, :class_name => Course::Course

  has_many :times, :class_name => BuisnessTime, :as => 'buisness_timeable'
end
