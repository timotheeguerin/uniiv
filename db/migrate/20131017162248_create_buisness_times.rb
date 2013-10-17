class CreateBuisnessTimes < ActiveRecord::Migration
  def change
    create_table :buisness_times do |t|
      t.references :day, index: true
      t.time :start_time
      t.time :end_time
      t.references :buisness_timeable, :polymorphic => true
      t.timestamps
    end
  end
end
