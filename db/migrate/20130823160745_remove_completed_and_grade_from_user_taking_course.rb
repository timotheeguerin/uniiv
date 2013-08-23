class RemoveCompletedAndGradeFromUserTakingCourse < ActiveRecord::Migration
  def change
    remove_column :user_taking_courses, :completed
    remove_column :user_taking_courses, :grade_id
  end
end
