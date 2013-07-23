class CreateProgramGroups < ActiveRecord::Migration
  def change
    create_table :program_groups do |t|
      t.string :name
      t.string :type
      t.integer :value
      t.references :parent, index: true

      t.timestamps
    end
  end
end
