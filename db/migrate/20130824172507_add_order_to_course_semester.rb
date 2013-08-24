class AddOrderToCourseSemester < ActiveRecord::Migration
  def change
    add_column :course_semesters, :order, :integer, :unique => true
  end
end
