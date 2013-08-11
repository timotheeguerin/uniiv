class CreateCourseRatingCriteria < ActiveRecord::Migration
  def change
    create_table :course_rating_criteria do |t|
      t.string :name

      t.timestamps
    end
  end
end
