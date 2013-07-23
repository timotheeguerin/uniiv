class ProgramGroup < ActiveRecord::Base
  belongs_to :parent, :class_name => ProgramGroup
  has_many :subgroups, :class_name => ProgramGroup, :foreign_key => "parent_id"
  has_and_belongs_to_many  :courses, :class_name => Course


end
