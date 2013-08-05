class AddPassCoreToCourseGradingSystemEntities < ActiveRecord::Migration
  def change
    add_column :course_grading_system_entities, :pass_core, :boolean
  end
end
