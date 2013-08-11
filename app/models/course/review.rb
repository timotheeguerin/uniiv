class Course::Review < ActiveRecord::Base
  belongs_to :user, class_name => User
  has_many :ratings, class_name => Course::Rating
end
