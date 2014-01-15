class Fgc::Scheme < ActiveRecord::Base
  belongs_to :prediction, :class_name => Fgc::Prediction
  has_many :percent, :class_name => Fgc::Percent
end
