class Program::GroupRestriction < ActiveRecord::Base
  belongs_to :group, :class_name => Program::Group
  belongs_to :type, :class_name => Program::GroupRestrictionType

  validates_presence_of :group_id
  validates_presence_of :type_id

  before_save :default_values

  def default_values
    self.value ||= 0 unless type.name == 'all'
  end

end
