class CreateCourseRatings < ActiveRecord::Migration
  def change
    create_table :course_ratings do |t|
      t.references :criteria, index: true
      t.references :review, index: true
      t.float :score

      t.timestamps
    end
  end
end
