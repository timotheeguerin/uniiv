class CreateUsersCoursesRecommendations < ActiveRecord::Migration
  def change
    create_table :users_courses_recommendations do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.float :score
      t.references :type

      t.timestamps
    end
  end
end
