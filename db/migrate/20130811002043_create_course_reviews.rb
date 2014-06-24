class CreateCourseReviews < ActiveRecord::Migration
  def change
    create_table :course_reviews do |t|
      t.references :user, index: true
      t.text :comments

      t.timestamps
    end
  end
end
