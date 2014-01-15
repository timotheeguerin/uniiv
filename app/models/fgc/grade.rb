class Fgc::Grade < ActiveRecord::Base
  belongs_to :group, :class_name => Fgc::Group

  def to_s
    "#{name}: #{value}"
  end
end
