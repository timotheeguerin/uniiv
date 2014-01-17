class Fgc::Group < ActiveRecord::Base
  belongs_to :prediction, :class_name => Fgc::Prediction
  has_many :grades, :class_name => Fgc::Grade
  has_one :percents, :class_name => Fgc::Percent
end
