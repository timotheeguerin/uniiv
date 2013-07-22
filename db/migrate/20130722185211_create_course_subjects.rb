class CreateCourseSubjects < ActiveRecord::Migration
  def change
    create_table :course_subjects do |t|
      t.string :name
      t.string :longname
      t.references :university, index: true

      t.timestamps
    end
  end
end
