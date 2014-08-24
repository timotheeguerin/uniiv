class RenameProgramModuleColumns < ActiveRecord::Migration
  def change
    rename_column :course_courses_program_groups, :program_group_id, :group_id
  end
end
