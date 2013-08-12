class ProgramGroup < ActiveRecord::Base

  belongs_to :restriction, :class_name => ProgramGroupRestriction
  belongs_to :groupparent, :polymorphic => true
  has_many :subgroups, :class_name => ProgramGroup, :as => :groupparent
  has_and_belongs_to_many :courses, :class_name => Course::Course

  #Complete a number of programs
  has_and_belongs_to_many :programs, :class_name => Program

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

  def get_requirement_level
    complexity = 0
    courses.each do |course|
      complexity += course.get_nb_requirements
    end
    subgroups.each do |subgroup|
      complexity += subgroup.get_requirement_level
    end
  end
end
