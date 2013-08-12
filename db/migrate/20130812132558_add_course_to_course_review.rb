class AddCourseToCourseReview < ActiveRecord::Migration
  def change
    add_reference :course_reviews, :course, index: true
  end
end
