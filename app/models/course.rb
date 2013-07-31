class Course < ActiveRecord::Base
  belongs_to :subject, :class_name => 'CourseSubject'
  belongs_to :prerequisite, :class_name => 'CourseExpr'
  belongs_to :corequisite, :class_name => 'CourseExpr'

  def to_s
    subject.to_s + ' ' + code.to_s
  end

  def id_to_s
    'c_' + id.to_s
  end
end
