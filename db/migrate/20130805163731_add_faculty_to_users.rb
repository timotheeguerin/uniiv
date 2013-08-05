class AddFacultyToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :faculty, index: true
  end
end
