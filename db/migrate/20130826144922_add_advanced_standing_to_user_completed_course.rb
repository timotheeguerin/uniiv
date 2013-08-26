class AddAdvancedStandingToUserCompletedCourse < ActiveRecord::Migration
  def change
    add_column :user_completed_courses, :advanced_standing, :boolean, :default => false
  end
end
