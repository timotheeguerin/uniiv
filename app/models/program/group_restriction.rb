class Program::GroupRestriction < ActiveRecord::Base
  belongs_to :group, :class_name => Program::Group
  belongs_to :type, :class_name => Program::GroupRestrictionType
end
