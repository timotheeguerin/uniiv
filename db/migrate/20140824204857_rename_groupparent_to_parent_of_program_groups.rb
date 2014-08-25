class RenameGroupparentToParentOfProgramGroups < ActiveRecord::Migration
  def change
    rename_column :program_groups, :parent_id, :parent_id
    rename_column :program_groups, :parent_type, :parent_type
  end
end
