class AddAdvancedStandingsCreditsToUser < ActiveRecord::Migration
  def change
    add_column :users, :advanced_standing_credits, :integer
  end
end
