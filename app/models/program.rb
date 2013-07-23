class Program < ActiveRecord::Base
  belongs_to type, :class_name => 'ProgramsType'
  belongs_to faculty, :class_name => 'Faculty'
  has_and_belongs_to_many  required_courses, :class_name => 'Course'
end
