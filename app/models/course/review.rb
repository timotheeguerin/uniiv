class Course::Review < ActiveRecord::Base
  belongs_to :user, :class_name => User
  belongs_to :course, :class_name => Course::Course
  has_many :ratings, :class_name => Course::Rating

  validates_uniqueness_of :course_id, :scope => :user_id
  accepts_nested_attributes_for :ratings, :allow_destroy => true

  def init_ratings
    ratings.destroy_all
    Course::RatingCriteria.all.each do |criteria|
      rating = Course::Rating.new
      rating.criteria = criteria
      ratings << rating
    end
  end
end
