class CreateProgramGroups < ActiveRecord::Migration
  def change
    create_table :program_groups do |t|
      t.string :name
      t.references :type, index: true
      t.integer :value
      t.references :parent, index: true

      t.timestamps
    end
  end
end
