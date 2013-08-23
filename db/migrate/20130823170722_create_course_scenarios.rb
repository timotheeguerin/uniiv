class CreateCourseScenarios < ActiveRecord::Migration
  def change
    create_table :course_scenarios do |t|
      t.boolean :main
      t.references :user, index: true

      t.timestamps
    end
  end
end
