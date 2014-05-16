class RenameProgramProgramToProgramProgramVersion < ActiveRecord::Migration
  def change
    #rename_table :program_programs, :program_program_versions
    rename_table :program_groups_programs, :program_groups_program_versions
    rename_table :course_scenarios_program_programs, :course_scenarios_program_program_versions

    rename_column :program_groups_program_versions, :program_id, :program_version_id
    rename_column :course_scenarios_program_program_versions, :program_id, :program_version_id
  end
end
