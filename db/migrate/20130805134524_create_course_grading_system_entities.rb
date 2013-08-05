class CreateCourseGradingSystemEntities < ActiveRecord::Migration
  def change
    create_table :course_grading_system_entities do |t|
      t.string :name
      t.float :value
      t.boolean :pass
      t.references :system, index: true

      t.timestamps
    end
  end
end
