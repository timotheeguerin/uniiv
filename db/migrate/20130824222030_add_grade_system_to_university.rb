class AddGradeSystemToUniversity < ActiveRecord::Migration
  def change
    add_reference :universities, :grade_system, index: true
  end
end
