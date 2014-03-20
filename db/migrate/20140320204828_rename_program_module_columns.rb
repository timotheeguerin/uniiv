class RenameProgramModuleColumns < ActiveRecord::Migration
  def change
    rename_column :course_courses_program_groups, :program_group_id, :group_id
    rename_column :course_subject_course_lists, :program_group_id, :group_id
  end
end
