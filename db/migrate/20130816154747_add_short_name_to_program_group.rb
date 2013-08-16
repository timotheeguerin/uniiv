class AddShortNameToProgramGroup < ActiveRecord::Migration
  def change
    add_column :program_groups, :short_name, :string
  end
end
