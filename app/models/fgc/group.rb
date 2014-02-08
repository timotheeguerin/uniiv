class Fgc::Group < ActiveRecord::Base
  belongs_to :prediction, :class_name => Fgc::Prediction
  has_many :grades, :class_name => Fgc::Grade
  has_many :percents, :class_name => Fgc::Percent

  def scheme_precent(scheme)
    scheme = scheme.id unless scheme.is_a? Numeric
    percents.each do |precent|
      if percent.scheme.id == scheme
        return percent
      end
    end
    nil
  end
end
