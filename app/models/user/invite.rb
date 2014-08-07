# User invites
class User::Invite < ActiveRecord::Base

  validate do
    errors.add(:used, 'All invite have been used with this key!') if used > amount
  end

  # Increment the used count
  def use(n=1)
    self.used += n
  end

  # Decrement the used count
  def unuse(n=1)
    self.used -= n
  end

  # Increment the used count and save
  # Warning: This save the model to the database automatically
  def use!(n=1)
    self.use(n)
    self.save
  end
end
