class RenameProgramGroupRestrictionsColumn < ActiveRecord::Migration
  def change
    rename_column :program_group_restrictions, :program_group_id, :group_id
  end
end
