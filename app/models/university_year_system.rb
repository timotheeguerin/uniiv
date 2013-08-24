class UniversityYearSystem < ActiveRecord::Base
  has_many :years, :class_name => UniversityYear, :foreign_key => :year_system_id

  def to_s
    name
  end
end
