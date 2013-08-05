class UserEmail < ActiveRecord::Base
  belongs_to :university, :class_name => University
  belongs_to :user, :class_name => User
  
  def to_s
      email
  end
end
