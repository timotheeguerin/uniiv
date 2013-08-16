class CreateCourseNodes < ActiveRecord::Migration
  def change
    create_table :course_nodes do |t|
      t.string :operation
      t.references :parent, index: true
      t.references :course, index: true

      t.timestamps
    end
  end
end
