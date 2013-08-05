class CreateUserCompletedCourses < ActiveRecord::Migration
  def change
    create_table :user_completed_courses do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.references :grade, index: true

      t.timestamps
    end
  end
end
