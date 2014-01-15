class CreateFgcGrades < ActiveRecord::Migration
  def change
    create_table :fgc_grades do |t|
      t.string :name
      t.float :value
      t.references :group, index: true

      t.timestamps
    end
  end
end
