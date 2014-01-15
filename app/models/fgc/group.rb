class Fgc::Group < ActiveRecord::Base
  belongs_to :prediction, :class_name => Fgc::Prediction
  has_many :grade, :class_name => Fgc::Grade
  has_one :percent, :class_name => Fgc::Percent
end
