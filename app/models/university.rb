class University < ActiveRecord::Base
  belongs_to :grading_system, :class_name => Course::GradingSystem
  belongs_to :year_system, :class_name => UniversityYearSystem

  has_many :faculties, :class_name => Faculty


  def to_s
    name.to_s
  end

  searchable do
    text :name
  end
end
