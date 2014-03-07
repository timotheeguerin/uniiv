class ChangeCourseRequirementColumnType < ActiveRecord::Migration
  def change
    change_column :admin_course_requirement_filleds, :prerequisite_read, :text
    change_column :admin_course_requirement_filleds, :corequisite_read, :text
  end
end
