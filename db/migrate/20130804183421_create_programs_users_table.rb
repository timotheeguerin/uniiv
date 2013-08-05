class CreateProgramsUsersTable < ActiveRecord::Migration
  def change
    create_table :programs_users do |t|
      t.references :program
      t.references :user
    end
  end
end
