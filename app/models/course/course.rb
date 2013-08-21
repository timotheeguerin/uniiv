class Course::Course < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :subject, :class_name => Course::Subject
  belongs_to :prerequisite, :class_name => Course::Expr
  belongs_to :corequisite, :class_name => Course::Expr

  has_many :reviews, :class_name => Course::Review

  validates_uniqueness_of :code, scope: :subject

  def to_s
    get_short_name
  end

  def to_link
    "<a href='#{course_path(:id => id)}' data-id='#{id}'>#{to_s}</a>"
  end

  def id_to_s
    'c_' + id.to_s
  end

  def get_short_name
    subject.to_s + ' ' + code.to_s
  end

  def get_dot_name
    subject.to_s + '\n' + code.to_s
  end

  def requirements_completed?(user, after_taking = false)
    unless prerequisite.nil? or prerequisite.requirements_completed?(user, after_taking)
      return false
    end
    unless  corequisite.nil? or corequisite.requirements_completed?(user, after_taking)
      return false
    end
    true
  end


  alias :can_take? :requirements_completed?

  def get_course_state(user)
    if user.has_completed_course?(self)
      CourseState::COMPLETED
    elsif user.is_taking_course?(self)
      CourseState::TAKING
    elsif user.can_take_course?(self)
      CourseState::AVAILABLE
    else
      CourseState::UNAVAILABLE
    end
  end

  def as_json(options={})
    hash = super(:except => [:created_at, :updated_at])
    hash[:prerequisite] = prerequisite.as_json
    hash[:corequisite] = corequisite.as_json
    hash
  end

  def count_requirements
    count = 0
    count += prerequisite.count_requirements unless prerequisite.nil?
    count += corequisite.count_requirements unless corequisite.nil?
    count
  end

  delegate :university, :to => :subject
end

class CourseState
  COMPLETED = 'completed'
  TAKING = 'taking'
  AVAILABLE = 'available'
  UNAVAILABLE = 'unavailable'
end
