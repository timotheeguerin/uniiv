class CreateFgcGroups < ActiveRecord::Migration
  def change
    create_table :fgc_groups do |t|
      t.references :prediction

      t.timestamps
    end
  end
end
