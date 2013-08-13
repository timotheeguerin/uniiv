class RemoveParentFromCourseNode < ActiveRecord::Migration
  def change
    remove_column :course_nodes, :parent_id
  end
end
