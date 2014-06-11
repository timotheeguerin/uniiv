class AddPartToCourseCourses < ActiveRecord::Migration
  def change
    add_column :course_courses, :part, :integer
  end
end
