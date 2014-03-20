class RenameProgramGroupRestricion < ActiveRecord::Migration
  def change
    rename_table :program_group_restrictions, :program_group_restriction_types
  end
end
