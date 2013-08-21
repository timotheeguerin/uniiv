class AddSemesterAndYearToUserTakingCourse < ActiveRecord::Migration
  def change
    add_reference :user_taking_courses, :semester, index: true
    add_column :user_taking_courses, :year, :integer
  end
end
