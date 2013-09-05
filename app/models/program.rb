class Program < ActiveRecord::Base
  belongs_to :type, :class_name => ProgramsType
  belongs_to :faculty, :class_name => Faculty
  has_many :groups, :class_name => ProgramGroup, :as => :groupparent

  #Allow only one faculty requirement per faculty
  validates_uniqueness_of :type_id, :scope => :faculty, :if => Proc.new { |obj| obj.type.name == 'faculty' }

  def to_s
    name.to_s+ " (#{type.to_s.capitalize})"
  end

  def to_long_s
    type.name.capitalize + ' in ' + name + ' (' + faculty.short_name + ')'
  end

  def get_completion_ratio(scenario, term=nil)
    ratio = 0
    coef = 0
    groups.each do |group|
      hash = group.get_completion_ratio(scenario, term)
      ratio += hash[:value]
      coef += hash[:coefficient]
    end
    {:ratio => ratio / coef.to_f, :coefficient => coef, :value => ratio}
  end

  def id_to_s
    'p_' + id.to_s
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

  searchable do
    integer :university_id do
      faculty.university_id
    end
    text :university do
      faculty.university.name
    end
    integer :faculty_id
    text :faculty do
      faculty.name
    end
    text :name
    text :type do
      type.name
    end
  end
end
