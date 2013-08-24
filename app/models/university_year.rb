class UniversityYear < ActiveRecord::Base
  belongs_to :year_system, :class_name => UniversityYearSystem
  validates_uniqueness_of :order, :scope => :year_system_id
  validates_uniqueness_of :name, :scope => :year_system_id

  def to_s
    name
  end
end
