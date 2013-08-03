class User < ActiveRecord::Base
  has_many :emails, :class_name => UserEmail
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (email = conditions.delete(:email))
      User.includes(:emails).where('user_emails.email = ?', email).first
    else
      super(warden_conditions)
    end
  end

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end
end
