class RenameProgram < ActiveRecord::Migration
  def change
    rename_table :programs, :program_programs
    rename_table :course_scenarios_programs, :course_scenarios_program_programs
  end
end