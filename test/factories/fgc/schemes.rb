# This will guess the Fgc::Scheme class
FactoryGirl.define do
  factory :fgc_scheme, :class => Fgc::Scheme do
    association :prediction, :factory => :fgc_prediction
  end
end