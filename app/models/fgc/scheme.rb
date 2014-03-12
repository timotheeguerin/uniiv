class Fgc::Scheme < ActiveRecord::Base
  belongs_to :prediction, :class_name => Fgc::Prediction, :touch => true
  has_many :percents, :class_name => Fgc::Percent
end
