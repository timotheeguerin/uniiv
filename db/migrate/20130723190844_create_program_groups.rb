class CreateProgramGroups < ActiveRecord::Migration
  def change
    create_table :program_groups do |t|
      t.string :name
      t.string :restriction
      t.integer :value
      t.references :groupparent, :polymorphic => true

      t.timestamps
    end
  end
end
