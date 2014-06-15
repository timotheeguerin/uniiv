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

  def to_sentence
    level_str= case operation
                 when 'LESS'
                   "#{level} or above"
                 when 'MORE'
                   "less than #{level}"
                 when 'EQ'
                   "between #{level} and #{level + 100}"
                 when 'DIFF'
                   "not between #{level} and #{level + 100}"
                 else
                   result
               end
    "Any courses in #{subject} at level #{level_str}"
  end

  #Return the list of courses
  def courses
    result = Course::Course.where(:subject_id => subject_id)
    l = level
    case operation
      when 'LESS'
        result.where('code < ?', l)
      when 'MORE'
        result.where('code >= ?', l)
      when 'EQ'
        result.where('code >= ? AND code < ?', l, l+100)
      when 'DIFF'
        result.where('code < ? OR code >= ?', l, l+100)
      else
        result
    end
  end

  def new_copy
    self.dup
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
