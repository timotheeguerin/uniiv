class BuisnessTime < ActiveRecord::Base
  belongs_to :day, :class_name => Day
  belongs_to :buisness_timeable, :polymorphic => true

  def to_s
    "#{day}: #{start_time} - #{end_time}"
  end
end
