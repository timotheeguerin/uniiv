class UserTakingCourse < ActiveRecord::Base
  belongs_to :course_scenario, :class_name => Course::Scenario
  belongs_to :course, :class_name => Course::Course
  belongs_to :semester, :class_name => Course::Semester

  validates_uniqueness_of :course_id, :scope => [:course_scenario]
  validates :course_id, :presence => true
  validates :course_scenario_id, :presence => true
  validates :semester, :presence => true
  validates :year, :presence => true

  validate :validate_couse_not_completed


  after_save :reindex
  after_destroy :reindex

  def user
    course_scenario.user unless course_scenario.nil?
  end

  def to_s
    user.to_s + ' - ' + course.to_s + ' ' + semester.to_s
  end

  def reindex
    course.index unless course.nil?
  end

  #Can the user take this course at this time
  def is_time_valid?(term = nil)
    term = Utils::Term.new(semester, year) if term.nil?
    course_scenario.can_take_course?(course, term)

  end

  searchable do

  end

  private
  def validate_couse_not_completed
    uid = user.id
    c_id = course_id
    completed_course = UserCompletedCourse.where { (user_id == uid) & (course_id == c_id) }.first
    unless completed_course.nil?
      errors.add(:course, 'completed')
    end
  end

  def term
    return nil if year.nil? or semesester.nil?
    Term.new(semester, year)
  end

  def term=(term)
    self.semester = term.semester
    self.year = term.year
  end

end
