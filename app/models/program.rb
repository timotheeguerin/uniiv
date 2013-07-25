class Program < ActiveRecord::Base
  belongs_to :type, :class_name => 'ProgramsType'
  belongs_to :faculty, :class_name => 'Faculty'
end
