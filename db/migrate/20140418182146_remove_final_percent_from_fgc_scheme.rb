class RemoveFinalPercentFromFgcScheme < ActiveRecord::Migration
  def change
    remove_column :fgc_schemes, :final_percent, :float
  end
end
