class CreateProgramProgramVersions < ActiveRecord::Migration
  def change
    create_table :program_program_versions do |t|
      t.references :program, index: true
      t.integer :start_year
      t.integer :end_year
      t.timestamps
    end
  end
end
