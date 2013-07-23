class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.string :type=string
      t.string :faculty

      t.timestamps
    end
  end
end
