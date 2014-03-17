class CreateCourseSubjectRequirementNodes < ActiveRecord::Migration
  def change
    create_table :course_subject_requirement_nodes do |t|
      t.integer :amount
      t.references :subject, index: true
      t.integer :level
      t.references :node, index: true

      t.timestamps
    end
  end
end
