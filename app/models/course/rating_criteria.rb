class Course::RatingCriteria < ActiveRecord::Base

  def to_s
    name
  end
end
