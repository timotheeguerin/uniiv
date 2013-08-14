class Faculty < ActiveRecord::Base
  belongs_to :university
  has_many :programs, :class_name => Program
  has_one :faculy_requirements, :conditions => {:type => ProgramsType.find_by_name('faculty')}, :class_name => Program

  def to_s
    name
  end
end
