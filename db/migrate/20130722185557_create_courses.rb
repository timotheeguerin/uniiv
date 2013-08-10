class CreateCourses < ActiveRecord::Migration
  def change
    create_table :course_courses do |t|
      t.string :name
      t.references :subject, index: true
      t.integer :code
      t.text :description
      t.integer :hours
      t.float :credit
      t.references :prerequisite, index: true
      t.references :corequisite, index: true

      t.timestamps
    end
  end
end
