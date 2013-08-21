class Course::Rating < ActiveRecord::Base
  belongs_to :criteria, :class_name => Course::RatingCriteria
  belongs_to :review, :class_name => Course::Review

  validates_uniqueness_of :criteria_id, :scope => :review_id

  def to_s
    criteria.to_s + ': ' + score
  end
end
