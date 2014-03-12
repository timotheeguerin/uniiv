class Fgc::Group < ActiveRecord::Base
  belongs_to :prediction, :class_name => Fgc::Prediction, :touch => true
  has_many :grades, :class_name => Fgc::Grade
  has_many :percents, :class_name => Fgc::Percent

  def scheme_percent(scheme)
    scheme = scheme.id unless scheme.is_a? Numeric
    percents.each do |percent|
      if percent.scheme.id == scheme
        return percent
      end
    end
    nil
  end
end
