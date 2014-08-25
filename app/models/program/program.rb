class Program::Program < ActiveRecord::Base
  belongs_to :type, :class_name => ProgramsType
  belongs_to :faculty, :class_name => Faculty

  #Allow only one faculty requirement per faculty
  validates_uniqueness_of :type_id, :scope => :faculty, :if => Proc.new { |obj| obj.type == ProgramsType.find_by_name('faculty') }

  has_many :versions, -> { order 'start_year desc' }, :class_name => Program::Version, :dependent => :destroy

  def to_s
    name.to_s+ " (#{type.to_s.capitalize})"
  end

  def to_long_s
    type.name.capitalize + ' in ' + name + ' (' + faculty.short_name + ')'
  end


  def id_to_s
    'p_' + id.to_s
  end

  def last_version
    versions.first
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