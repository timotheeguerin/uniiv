class Program < ActiveRecord::Base
  belongs_to :type, :class_name => 'ProgramType'
  belongs_to :faculty, :class_name => 'Faculty'
end
