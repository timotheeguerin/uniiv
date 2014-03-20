class Faculty < ActiveRecord::Base
  belongs_to :university
  has_many :programs, :class_name => Program::Program
  has_one :faculty_requirements, -> { where :type_id => ProgramsType.find_by_name('faculty') }, :class_name => Program::Program

  def to_s
    name
  end

  searchable do
    integer :university_id
    text :university do
      university.name
    end
    text :name
  end
end
