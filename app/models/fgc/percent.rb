class Fgc::Percent < ActiveRecord::Base
  belongs_to :group, :class_name => Fgc::Group
  belongs_to :scheme, :class_name => Fgc::Scheme
  def to_s
    value
  end
end
