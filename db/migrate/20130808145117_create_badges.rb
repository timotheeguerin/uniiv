class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :desciption
      t.integer :point

      t.timestamps
    end
  end
end
