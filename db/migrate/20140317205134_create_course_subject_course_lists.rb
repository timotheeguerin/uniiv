class CreateCourseSubjectCourseLists < ActiveRecord::Migration
  def change
    create_table :course_subject_course_lists do |t|
      t.references :subject, index: true
      t.integer :level
      t.string :operation
      t.references :program_group, index: true

      t.timestamps
    end
  end
end
