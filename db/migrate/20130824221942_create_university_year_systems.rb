class CreateUniversityYearSystems < ActiveRecord::Migration
  def change
    create_table :university_year_systems do |t|
      t.string :name

      t.timestamps
    end
  end
end
