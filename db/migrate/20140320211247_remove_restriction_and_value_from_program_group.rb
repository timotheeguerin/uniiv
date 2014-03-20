class RemoveRestrictionAndValueFromProgramGroup < ActiveRecord::Migration
  def change
    remove_reference :program_groups, :restriction, index: true
    remove_column :program_groups, :value, :integer
  end
end
