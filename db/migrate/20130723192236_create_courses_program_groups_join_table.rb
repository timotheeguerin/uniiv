class CreateCoursesProgramGroupsJoinTable < ActiveRecord::Migration
  def change
    create_table :course_courses_program_groups, :id => false do |t|
      t.integer :program_group_id
      t.integer :course_id
    end
  end
end
