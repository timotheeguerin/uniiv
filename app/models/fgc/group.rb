class Fgc::Group < ActiveRecord::Base
  belongs_to :prediction, :class_name => Fgc::Prediction
  has_many :grades, :class_name => Fgc::Grade
  has_many :percents, :class_name => Fgc::Percent
end
