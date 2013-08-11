class CreateProgramGroupsProgramsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :programs, :program_groups do |t|
      # t.index [:program_id, :program_group_id]
      # t.index [:program_group_id, :program_id]
    end
  end
end
