class Course::Course < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :subject, :class_name => Course::Subject
  belongs_to :prerequisite, :class_name => Course::Expr
  belongs_to :corequisite, :class_name => Course::Expr

  has_many :reviews, :class_name => Course::Review, :dependent => :destroy

  has_and_belongs_to_many :restricted_years, :class_name => 'UniversityYear'
  has_many :scenario_taking_courses, :class_name => UserTakingCourse, :foreign_key => 'course_id', :dependent => :destroy
  has_many :user_completed_courses, :class_name => UserCompletedCourse, :foreign_key => 'course_id', :dependent => :destroy
  has_many :users, :class_name => User, :through => :user_completed_courses
  has_many :course_scenarios, :through => :scenario_taking_courses, :class_name => Course::Scenario

  #Program group having the course
  has_and_belongs_to_many :program_groups, :class_name => 'Program::Group'


  #Admin
  has_one :admin_course_requirement_filled, :class_name => Admin::CourseRequirementFilled

  #Validations
  validates_uniqueness_of :code, scope: [:subject, :part]
  validates :subject_id, :presence => true
  validates :name, :presence => true
  validates :code, :presence => true
  validates :description, :presence => true
  validates :credit, :presence => true
  validates :hours, :presence => true

  #Callbacks
  after_create :after_create

  after_update :check_requirements


  def after_create
    filled = Admin::CourseRequirementFilled.new
    filled.corequisites=false
    filled.prerequisites=false
    filled.course = self
    filled.save
  end

  def check_requirements
    if prerequisite_id_changed? and not prerequisite_id_was.nil?
      Course::Expr.find(prerequisite_id_was).check_destroy
    end
    if corequisite_id_changed? and not prerequisite_id_was.nil?
      Course::Expr.find(corequisite_id_was).check_destroy
    end
  end

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
    ext = if part
            "D#{part}"
          else
            ''
          end
    "#{subject} #{code}#{ext}"
  end

  def get_detail_name
    "#{get_short_name}: #{name}"
  end

  #Return the name for the DOT graph
  def get_dot_name
    subject.to_s + '\n' + code.to_s
  end

  def requirements_completed?(scenario, term = nil)
    unless prerequisite.nil? or prerequisite.requirements_completed?(scenario, term)
      return false
    end
    next_term = nil
    next_term = term.next unless term.nil?
    unless  corequisite.nil? or corequisite.requirements_completed?(scenario, next_term)
      return false
    end
    true
  end


  alias :can_take? :requirements_completed?

  def get_course_state(scenario, term = nil)
    user = scenario.user
    if scenario.has_completed_course?(self, true, term)
      CourseState::COMPLETED
    elsif scenario.plan_to_take_course?(self)
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

  def self.search_course(params)
    scenario = params[:scenario]
    search = Course::Course.search do
      fulltext query if params[:q]
      paginate(:page => 1, :per_page => params[:limit]) unless params[:limit].nil?
      unless scenario.nil?
        without(:course_scenario_ids, scenario.id) if params[:only_not_taking]
        with(:course_scenario_ids, scenario.id) if params[:only_taking]
        without(:user_ids, scenario.user.id) if params[:only_not_completed]
        with(:user_ids, scenario.user.id) if params[:only_completed]
      end
      with(:program_group_ids, params[:program_groups]) if params[:program_groups]
      with(:program_ids, params[:program]) if params[:program]
    end
    search.results
  end

  #Sunspot indexing
  searchable do
    text :subject do
      subject.name
    end
    text :program do
      program_groups.map { |group| group.parent_program.to_s }
    end
    text :description
    text :code
    integer :subject_id
    integer :course_scenario_ids, :references => Course::Scenario, :multiple => true
    integer :user_ids, :references => User, :multiple => true
    integer :program_group_ids, :references => Program::Group, :multiple => true
    integer :program_ids, :references => Program::Program, :multiple => true do
      program_groups.map { |group| group.parent_program.id }
    end
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

  def already_exist?
    Course::Course.where(:subject_id => subject_id, :code => code, :part => part).size > 0
  end

  #Get the course from the string of format SUBJECT CODE(e.g. MATH 222)
  def self.find_by_string(str, university)
    array = str.split(/[[:space:]]/)
    subject = Course::Subject.where(:name => array[0], :university_id => university.id).first
    code = array[1]
    Course::Course.where(:subject_id => subject.id, :code => code).first
  end
end

