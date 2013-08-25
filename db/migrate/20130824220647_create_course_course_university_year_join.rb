class CreateCourseCourseUniversityYearJoin < ActiveRecord::Migration
  def change
    create_table :course_courses_university_years do |t|
      t.references :course, index: true
      t.references :university_year, index: true
    end
  end
end
