class Program < ActiveRecord::Base
  belongs_to :type, :class_name => 'ProgramsType'
  belongs_to :faculty, :class_name => 'Faculty'
  has_many :groups, :class_name => ProgramGroup, :as => :groupparent

  def to_s
    name
  end
end
