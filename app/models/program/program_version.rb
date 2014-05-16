class Program::ProgramVersion < ActiveRecord::Base
  belongs_to :program, :class_name => Program::Program

end
