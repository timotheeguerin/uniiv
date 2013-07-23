class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.string :name
      t.string :website
      t.references :university, index: true

      t.timestamps
    end
  end
end
