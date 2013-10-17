class CreateCourseSchedules < ActiveRecord::Migration
  def change
    create_table :course_schedules do |t|
      t.integer :year
      t.references :semester, index: true
      t.references :course, index: true
      t.integer :capacity

      t.timestamps
    end
  end
end
