class RenameProgramUsersToProgramsScenarios < ActiveRecord::Migration
  def change
    rename_table :programs_users, :course_scenarios_programs
    rename_column :course_scenarios_programs, :user_id, :scenario_id
  end
end
