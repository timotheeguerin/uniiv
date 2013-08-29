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

    puts '---------------------------'
    puts name
    groups.each do |group|
      hash = group.get_completion_ratio(scenario, term)
      ratio += hash[:value]
      coef += hash[:coefficient]
    end
    puts 'ra: ' + ratio.to_s
    puts 'coef: ' + coef.to_s
    {:ratio => ratio / coef.to_f, :coefficient => coef, :value => ratio}
  end

  def id_to_s
    'p_' + id.to_s
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
