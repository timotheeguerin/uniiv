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
end
