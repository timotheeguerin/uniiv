class AddMinScoreToGradingSystemEntities < ActiveRecord::Migration
  def change
    add_column :course_grading_system_entities, :min_score, :float
  end
end
