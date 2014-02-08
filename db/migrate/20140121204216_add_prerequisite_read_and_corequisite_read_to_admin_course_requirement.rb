class AddPrerequisiteReadAndCorequisiteReadToAdminCourseRequirement < ActiveRecord::Migration
  def change
    add_column :admin_course_requirement_filleds, :prerequisite_read, :string
    add_column :admin_course_requirement_filleds, :corequisite_read, :string
  end
end
