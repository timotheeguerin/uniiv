# This will guess the Fgc::Prediction class
FactoryGirl.define do
  factory :fgc_prediction, :class => Fgc::Prediction do
    user
    association :course, :factory => :course_course
  end
end