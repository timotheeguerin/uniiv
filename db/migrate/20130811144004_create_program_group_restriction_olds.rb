class CreateProgramGroupRestrictionOlds < ActiveRecord::Migration
  def change
    create_table :program_group_restrictions do |t|
      t.string :name

      t.timestamps
    end
  end
end
