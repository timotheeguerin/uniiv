class UserEmail < ActiveRecord::Base
  belongs_to :university, :class_name => University
  belongs_to :user, :class_name => User

  validates_uniqueness_of :email

  def to_s
    email
  end
end
