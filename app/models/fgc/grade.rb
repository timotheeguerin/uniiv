class Fgc::Grade < ActiveRecord::Base
  belongs_to :group, :class_name => Fgc::Group

  before_save :set_default

  def set_default
    self.value ||= 0
  end

  def to_s
    "#{name}: #{value}"
  end
end
