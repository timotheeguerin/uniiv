class Course < ActiveRecord::Base
  belongs_to :subject, :class_name => 'CourseSubject'
  belongs_to :prerequisite, :class_name => 'CourseExpr'
  belongs_to :corequisite, :class_name => 'CourseExpr'

  def to_s
    get_short_name
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

  def requirements_completed?(user)
    unless prerequisite.nil? or prerequisite.requirements_completed?(user)
      return false
    end
    unless  corequisite.nil? or corequisite.requirements_completed?(user)
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
   hash = super(:except =>[:created_at, :updated_at])
   hash[:prerequisite] = prerequisite.as_json
   hash[:corequisite] = corequisite.as_json
   hash   
 end
end

class CourseState
  COMPLETED = 'completed'
  TAKING = 'taking'
  AVAILABLE = 'available'
  UNAVAILABLE = 'unavailable'
end
