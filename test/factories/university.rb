# This will guess the User class
FactoryGirl.define do
  factory :university do
    association :grading_system, :factory => :course_grading_system
    name 'University test'
  end
end