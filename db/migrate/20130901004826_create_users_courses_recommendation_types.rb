class CreateUsersCoursesRecommendationTypes < ActiveRecord::Migration
  def change
    create_table :users_courses_recommendation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
