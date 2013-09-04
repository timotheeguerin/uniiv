class Course::Course < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :subject, :class_name => Course::Subject
  belongs_to :prerequisite, :class_name => Course::Expr
  belongs_to :corequisite, :class_name => Course::Expr

  has_many :reviews, :class_name => Course::Review

  has_and_belongs_to_many :restricted_years, :class_name => UniversityYear
  has_many :scenario_taking_courses, :class_name => UserTakingCourse, :foreign_key => 'course_id'
  has_many :user_completed_courses, :class_name => UserCompletedCourse, :foreign_key => 'course_id'
  has_many :users, :class_name => User, :through => :user_completed_courses
  has_many :course_scenarios, :through => :scenario_taking_courses, :class_name => Course::Scenario

  has_and_belongs_to_many :program_groups, :class_name => ProgramGroup


  #Validations
  validates_uniqueness_of :code, scope: :subject
  validates :subject_id, :presence => true
  validates :name, :presence => true
  validates :code, :presence => true
  validates :description, :presence => true
  validates :credit, :presence => true
  validates :hours, :presence => true

  #Remove all association after destroy
  after_destroy :delete_association

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

  def requirements_completed?(scenario, term = nil)
    puts 'pre: ' + prerequisite.requirements_completed?(scenario, term).to_s unless prerequisite.nil?
    unless prerequisite.nil? or prerequisite.requirements_completed?(scenario, term)
      return false
    end
    unless  corequisite.nil? or corequisite.requirements_completed?(scenario, term.next)
      return false
    end
    true
  end


  alias :can_take? :requirements_completed?

  def get_course_state(scenario, term = nil)
    user = scenario.user
    if scenario.has_completed_course?(self, true, term)
      CourseState::COMPLETED
    elsif scenario.is_taking_course?(self, term)
      CourseState::TAKING
    elsif scenario.can_take_course?(self, term)
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

  searchable do
    text :subject do
      subject.name
    end
    text :programs do
      program_groups.map { |group| group.parent_program.to_s }
    end
    text :description
    text :code
    integer :course_scenario_ids, :references => Course::Scenario, :multiple => true
    integer :user_ids, :references => User, :multiple => true
  end

  #Compute the completxity to get to this course with all the prerequisite
  def get_complexity
    prerequisite.get_complexity
  end

  def list_dependencies(options = {})
    default_options = {
        :inc_pre => true,
        :inc_co => true
    }
    options = options.reverse_merge(default_options)
    courses = []
    if not prerequisite.nil? and options[:inc_pre]
      courses += prerequisite.list_dependencies
    end
    if corequisite.nil? and options[:inc_co]
      courses += corequisite.list_dependencies
    end
    courses
  end

  def delete_association
    scenario_taking_courses.destroy_all
    user_completed_courses.destroy_all
  end
end

class CourseState
  COMPLETED = 'completed'
  TAKING = 'taking'
  AVAILABLE = 'available'
  UNAVAILABLE = 'unavailable'
end
