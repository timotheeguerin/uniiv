# User invites
class User::Invite < ActiveRecord::Base

  validates_presence_of :message, :amount, :key, :used, :category

  validate do
    errors.add(:used, 'All invite have been used with this key!') if used > amount
  end

  before_validation :update_key, on: :create

  def update_key
    self.key = SecureRandom.hex(8)
  end

  # Increment the used count
  def use(n=1)
    self.used += n
  end

  # Decrement the used count
  def unuse(n=1)
    self.used -= n
  end

  def left
    amount - used
  end

  # Increment the used count and save
  # Warning: This save the model to the database automatically
  def use!(n=1)
    self.use(n)
    self.save
  end
end
