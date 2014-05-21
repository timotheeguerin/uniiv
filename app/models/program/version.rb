class Program::Version < ActiveRecord::Base
  belongs_to :program, :class_name => Program::Program
  has_many :groups, :class_name => Program::Group, :as => :groupparent

  validates_presence_of :program_id

  def to_s
    program.name.to_s+ " (#{program.type.to_s.capitalize})"
  end


  def id_to_s
    'p_' + id.to_s
  end

  def to_academic_year
    "#{start_year}-#{end_year}"
  end

  def type
    program.type
  end

  def get_completion_ratio(scenario, term=nil)
    ratio = Utils::Ratio.zero
    groups.each do |group|
      ratio += group.get_completion_ratio(scenario, term)
    end
    ratio
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
    groups.each do |group|
      result += group.get_all_courses(options)
    end
    result
  end

  def new_copy
    version = self.dup
    version.groups = self.groups.map(&:new_copy)
    version
  end
end
