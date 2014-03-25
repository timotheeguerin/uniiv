class RenameSystemToGradingSystemInCourseGradingSystemEntity < ActiveRecord::Migration
  def change
    rename_column :course_grading_system_entities, :system_id, :grading_system_id
  end
end
