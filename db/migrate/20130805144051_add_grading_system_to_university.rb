class AddGradingSystemToUniversity < ActiveRecord::Migration
  def change
    add_reference :universities, :grading_system, index: true
  end
end
