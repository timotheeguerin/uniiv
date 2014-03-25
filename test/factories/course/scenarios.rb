# This will guess the User class
FactoryGirl.define do
  factory :course_scenario, :class => Course::Scenario do
    user
    factory :course_main_scenario do
      main true
    end
  end

end