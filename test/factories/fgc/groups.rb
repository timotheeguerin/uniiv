# This will guess the Fgc::Prediction class
FactoryGirl.define do
  factory :fgc_group, :class => Fgc::Group do
    association :prediction, :factory => :fgc_prediction
  end
end