class Course::Rating < ActiveRecord::Base
  belongs_to :criteria, :class_name => Course::RatingCriteria
  belongs_to :review, :class_name => Course::Review
end
