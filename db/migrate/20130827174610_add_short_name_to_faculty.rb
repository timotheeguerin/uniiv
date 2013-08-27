class AddShortNameToFaculty < ActiveRecord::Migration
  def change
    add_column :faculties, :short_name, :string
  end
end
