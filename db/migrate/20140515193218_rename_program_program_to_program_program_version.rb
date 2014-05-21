class RenameProgramProgramToProgramProgramVersion < ActiveRecord::Migration
  def change
    rename_table :course_scenarios_program_programs, :course_scenarios_program_versions
    rename_column :course_scenarios_program_versions, :program_id, :version_id
  end
end
