class AddCompletedAndGradeToUserTakingCourse < ActiveRecord::Migration
  def change
    add_column :user_taking_courses, :completed, :boolean
    add_reference :user_taking_courses, :grade, index: true
  end
end
