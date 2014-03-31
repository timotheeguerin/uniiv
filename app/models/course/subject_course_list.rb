class Course::SubjectCourseList < ActiveRecord::Base
  belongs_to :subject, :class_name => Course::Subject
  belongs_to :group, :class_name => Program::Group

  validates_presence_of :subject
  validates_presence_of :group
  validates_presence_of :level
  validates_presence_of :operation

  def to_s
    "#{subject} with  level #{operation} #{level}"
  end

  #Return the list of courses
  def courses
    result = Course::Course.where(:subject_id => subject_id)
    l = level
    case operation
      when Course::SubjectCourseListOperation::LESS
        result.where { code < l }
      when Course::SubjectCourseListOperation::MORE
        result.where { code >= l }
      when Course::SubjectCourseListOperation::EQ
        result.where { code >= l and code < l+100 }
      when Course::SubjectCourseListOperation::DIFF
        result.where { code < l or code >= l+100 }
    end
  end
end

class Course::SubjectCourseListOperation
  LESS = 'LESS' #All the course with a code less than the given one
  MORE = 'MORE' #ALl the courses with a code more than or equals to the level
  EQ = 'EQ'
  DIFF = 'DIFF'

  def self.to_a
    [LESS, MORE, EQ, DIFF]
  end
end
