class CreateCourseExprs < ActiveRecord::Migration
  def change
    create_table :course_exprs do |t|
      t.references :node, index: true

      t.timestamps
    end
  end
end
