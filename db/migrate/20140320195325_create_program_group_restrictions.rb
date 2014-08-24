class CreateProgramGroupRestrictions < ActiveRecord::Migration
  def change
    create_table :program_group_restrictions do |t|
      t.references :group, index: true
      t.integer :value
      t.references :type, index: true

      t.timestamps
    end
  end
end
