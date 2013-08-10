class CreateCourseRatingCriterias < ActiveRecord::Migration
  def change
    create_table :course_rating_criterias do |t|
      t.string :name

      t.timestamps
    end
  end
end
