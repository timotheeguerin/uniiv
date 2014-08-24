# This will guess the User class
FactoryGirl.define do
  factory :course_grading_system_entity, :class => Course::GradingSystemEntity do
    association :grading_system, :factory => :course_grading_system
    pass true
    sequence :name do |n|
      "Entity #{n}"
    end

    sequence :value do |n|
      n
    end
    factory :course_fail_grade do
      pass false
    end
  end
end