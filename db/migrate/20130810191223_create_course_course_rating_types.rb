class CreateCourseCourseRatingTypes < ActiveRecord::Migration
  def change
    create_table :course_rating_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
