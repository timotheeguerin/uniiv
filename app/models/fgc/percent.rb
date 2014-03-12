class Fgc::Percent < ActiveRecord::Base
  belongs_to :group, :class_name => Fgc::Group, :touch => true
  belongs_to :scheme, :class_name => Fgc::Scheme, :touch => true
  def to_s
    value
  end
end
