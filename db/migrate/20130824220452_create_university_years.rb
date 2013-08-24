class CreateUniversityYears < ActiveRecord::Migration
  def change
    create_table :university_years do |t|
      t.string :name
      t.integer :order
      t.references :year_system

      t.timestamps
    end
  end
end
