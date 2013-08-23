class AddSemesterAndYearToUserCompletedCourse < ActiveRecord::Migration
  def change
    add_reference :user_completed_courses, :semester, index: true
    add_column :user_completed_courses, :year, :integer
  end
end
