class Fgc::Percent < ActiveRecord::Base
  belongs_to :group, :class_name => Fgc::Group, :touch => true
  belongs_to :scheme, :class_name => Fgc::Scheme, :touch => true

  before_save :set_default

  def set_default
    self.value ||= 0
  end

  def to_s
    value
  end
end
