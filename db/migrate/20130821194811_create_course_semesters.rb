class CreateCourseSemesters < ActiveRecord::Migration
  def change
    create_table :course_semesters do |t|
      t.string :name

      t.timestamps
    end
  end
end
