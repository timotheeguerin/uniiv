class RenameGroupparentToParentOfProgramGroups < ActiveRecord::Migration
  def change
    rename_column :program_groups, :groupparent_id, :parent_id
    rename_column :program_groups, :groupparent_type, :parent_type
  end
end
