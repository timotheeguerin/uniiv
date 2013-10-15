class CreateAdminCourseRequirementFilleds < ActiveRecord::Migration
  def change
    create_table :admin_course_requirement_filleds do |t|
      t.boolean :prerequisites
      t.boolean :corequisites
      t.references :course, index: true

      t.timestamps
    end
  end
end
