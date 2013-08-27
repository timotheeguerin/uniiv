class UserTakingCourse < ActiveRecord::Base
  belongs_to :course_scenario, :class_name => Course::Scenario
  belongs_to :course, :class_name => Course::Course
  belongs_to :semester, :class_name => Course::Semester

  accepts_nested_attributes_for :semester

  validates_uniqueness_of :course_id, :scope => [:course_scenario]
  validates :course_id, :presence => true
  validates :course_scenario_id, :presence => true
  validates :semester, :presence => true
  validates :year, :presence => true

  after_save :reindex

  def user
    course_scenario.user
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
