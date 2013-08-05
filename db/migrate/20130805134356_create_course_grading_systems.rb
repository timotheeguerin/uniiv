class CreateCourseGradingSystems < ActiveRecord::Migration
  def change
    create_table :course_grading_systems do |t|
      t.string :name

      t.timestamps
    end
  end
end
