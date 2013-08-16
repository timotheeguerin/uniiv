class User < ActiveRecord::Base

  belongs_to :university, :class_name => University
  belongs_to :faculty, :class_name => Faculty

  has_many :emails, :class_name => UserEmail

  has_and_belongs_to_many :roles

  has_and_belongs_to_many :programs

  has_many :taking_courses, :class_name => UserTakingCourse
  has_many :completed_courses, :class_name => UserCompletedCourse

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
      where(conditions).first
    end
  end

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end


  def permitted_params
    params.permit!
  end


  def has_completed_course?(course)
    completed_courses.each do |c|
      if c.course == course
        return true
      end
    end
    false
  end

  def is_taking_course?(course)
    taking_courses.each do |c|
      if c.course == course
        return true
      end
    end
    false
  end

  def requirements_completed?(course)
    course.requirements_completed?(self)
  end

  def to_s
    email
  end

  alias :can_take_course? :requirements_completed?
end
