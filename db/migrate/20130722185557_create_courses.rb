class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.references :subject, index: true
      t.integer :code
      t.text :description
      t.integer :hours
      t.integer :credit
      t.references :prerequisite, index: true
      t.references :corequisite, index: true

      t.timestamps
    end
  end
end
