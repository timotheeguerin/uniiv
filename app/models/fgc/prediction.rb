class Fgc::Prediction < ActiveRecord::Base
  belongs_to :user, :class_name => User
  belongs_to :course, :class_name => Course::Course
  has_many :schemes, :class_name => Fgc::Scheme
  has_many :groups, :class_name => Fgc::Group

  validate :validation


  def validation
    errors.add(:schemes, t('fgc.too_much_schemes')) unless can_add_more_schemes?
  end

  #Allow up to 5 schemes
  def can_add_more_schemes?
    schemes.size < 5
  end
end
