class Course::SubjectCourseList < ActiveRecord::Base
  belongs_to :subject, :class_name => Course::Subject
  belongs_to :program_group, :class_name => ProgramGroup

  validates_presence_of :subject
  validates_presence_of :program_group
  validates_presence_of :level
  validates_presence_of :operation

  def to_s
    "#{subject} with  level #{operation} #{level}"
  end

  #Return the list of courses
  def courses
    Course::Course.where{subject_id = subject_id}
  end
end

class Course::SubjectCourseListOperation
  LESS = 'LESS'
  MORE = 'MORE'
  EQ = 'EQ'
  DIFF = 'DIFF'

  def self.to_a
    [LESS, MORE, EQ, DIFF]
  end
end
