class UserTakingCourse < ActiveRecord::Base
  belongs_to :course_scenario, :class_name => Course::Scenario
  belongs_to :course, :class_name => Course::Course
  belongs_to :semester, :class_name => Course::Semester

  validates_uniqueness_of :course_id, :scope => [:course_scenario]
  validates :course_id, :presence => true
  validates :course_scenario_id, :presence => true
  validates :semester, :presence => true
  validates :year, :presence => true

  validate :couse_not_completed

  def couse_not_completed
    uid = user.id
    c_id = course_id
    UserCompletedCourse.where { (user_id = uid) & (course_id == c_id) }
    errors.add(:course_completed, t('course.already.completed'))
  end

  after_save :reindex

  def user
    course_scenario.user unless course_scenario.nil?
  end

  def to_s
    user.to_s + ' - ' + course.to_s + ' ' + semester.to_s
  end

  def reindex
    course.index
  end

  searchable do

  end

end
