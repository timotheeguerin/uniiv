class Course::Review < ActiveRecord::Base
  belongs_to :user, class_name => User
  belongs_to :course, class_name => Course::Course
  has_many :ratings, class_name => Course::Rating

  validates_uniqueness_of :course, :scope => :user
end
