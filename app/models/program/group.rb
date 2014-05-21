class Program::Group < ActiveRecord::Base

  belongs_to :groupparent, :polymorphic => true, :dependent => :destroy

  has_many :subgroups, :class_name => Program::Group, :as => :groupparent

  #List of courses to complete
  has_and_belongs_to_many :list_courses, -> { uniq }, :class_name => Course::Course

  #List of the subject_courses
  has_many :subject_courses, :class_name => Course::SubjectCourseList, :dependent => :destroy

  has_many :restrictions, :class_name => Program::GroupRestriction, :dependent => :destroy

  #Complete a number of programs
  has_and_belongs_to_many :programs, -> { uniq }, :class_name => Program::Program

  validates_presence_of :groupparent_id

  def courses
    result = list_courses
    subject_courses.each do |subject_course|
      result += subject_course.courses
    end
    result
  end

  def to_s
    name.to_s + " (#{type.to_s})"
  end

  def type
    if groupparent.nil?
      ''
    else
      groupparent.type
    end
  end

  def parent_program
    if groupparent.nil?
      nil
    elsif groupparent.is_a?(Program::Version)
      groupparent
    else
      groupparent.parent_program
    end
  end


  def get_requirement_level
    complexity = 0
    courses.each do |course|
      complexity += course.count_requirements
    end
    subgroups.each do |subgroup|
      complexity += subgroup.get_requirement_level
    end
    complexity
  end

  def get_subgroups_completed_ratio(scenario, term = nil)
    ratios = []
    subgroups.each do |subgroup|
      ratios << subgroup.get_completion_ratio(scenario, term)
    end
    ratios
  end

  def count_completed_courses(scenario, term= nil)
    count = 0
    courses.each do |course|
      count += 1 if scenario.has_completed_course?(course, term)
    end
    count
  end

  def count_credit_completed_courses(scenario, term = nil)
    count = 0
    courses.each do |course|
      count += course.credit if scenario.has_completed_course?(course, true, term)
    end
    subgroups.each do |subgroup|
      count += subgroup.count_credit_completed_courses(scenario, term)
    end
    count
  end

  def count_total_credit
    count = 0
    courses.each do |course|
      count += course.credit
    end
    subgroups.each do |subgroup|
      count += subgroup.count_total_credit
    end
    count
  end

  #Count all the courses in the group and subgroups
  def count_all_courses
    count = courses.size()
    subgroups.each do |subgroup|
      count += subgroup.count_all_courses
    end
    count
  end

  def get_completion_ratio(scenario, term = nil)
    if restrictions.size == 0
      puts 'Epty: '
      Utils::Ratio.empty
    else

      ratio = Utils::Ratio.zero
      restrictions.each do |restriction|
        ratio += restriction.get_completition_ratio(scenario, term)
        puts 'READ res: ' + restriction.type.to_s
      end
      puts 'GR: ' + ratio.to_s
      ratio
    end
  end

  def get_coefficient
    restriction = restrictions.first
    case restriction.type.name
      when 'min_credit'
        restriction.value
      when 'min_grp'
        return 1
      else
        count_total_credit
    end
  end

  def get_all_courses(options={})
    result = []
    default_options={
        :only_taking => false,
        :only_not_taking => false,
        :only_completed => false,
        :only_not_completed => false
    }
    options = options.reverse_merge(default_options)
    scenario = options[:scenario]
    result = courses
    unless scenario.nil?
      result = result.where do
        id.in(scenario.taking_courses.pluck(:course_id)) if options[:only_taking] and
            id.in(scenario.user.completed_courses.pluck(:course_id)) if options[:only_completed] and
            id.not_in(scenario.taking_courses.pluck(:course_id)) if options[:only_not_taking] and
            id.not_in(scenario.user.completed_courses.pluck(:course_id)) if options[:only_not_completed]
      end
    end
    result
  end

  def completed?(scenario, options = {})
    default_options = {
        :planning => false #Check also using the course the user is taking
    }
    options = default_options.merge(options)
    term = nil

    if options[:planning]
      term = Utils::Term::last_allowed
    end
    get_completion_ratio(scenario, term) == 1
  end

  def id_to_s
    'g_' + id.to_s
  end

  def new_copy
    group = self.dup
    group.subgroups = self.subgroups.map(&:new_copy)
    group.list_courses = self.list_courses
    group.subject_courses = self.subject_courses.map(&:new_copy)
    group.restrictions = self.restrictions.map(&:new_copy)
    group.programs = self.programs
    group
  end

  searchable do
    text :program do
      parent_program.program.name unless parent_program.nil?
    end
    text :name
  end
end