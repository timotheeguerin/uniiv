class RenameProgramGroupToGroupInProgramGroupPrograms < ActiveRecord::Migration
  def change
    rename_column :program_groups_programs, :program_group_id, :group_id
  end
end
