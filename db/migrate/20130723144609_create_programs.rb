class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.references :type, index: true
      t.references :faculty, index: true

      t.timestamps
    end
  end
end
