class Fgc::Prediction < ActiveRecord::Base
  belongs_to :user, :class_name => User
  belongs_to :course, :class_name => Course::Course
  has_many :schemes, :class_name => Fgc::Prediction
  has_many :groups, :class_name => Fgc::Group
end
