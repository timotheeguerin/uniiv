class RenameUserToCourseScenarioInUserTakingCourse < ActiveRecord::Migration
  def change
    rename_column :user_taking_courses, :user_id, :course_scenario_id
  end
end
