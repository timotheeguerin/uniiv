class Faculty < ActiveRecord::Base
	belongs_to :university
	has_many :programs, :class_name => Program 
  
  def to_s
    name
  end
end
