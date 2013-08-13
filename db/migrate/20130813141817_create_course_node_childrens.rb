class CreateCourseNodeChildrens < ActiveRecord::Migration
  def change
    create_table :course_node_childrens do |t|
      t.references :course_node
      t.integer :children_id
    end
  end
end
