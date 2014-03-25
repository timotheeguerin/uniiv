# This will guess the User class
FactoryGirl.define do
  factory :course_grading_system_entity, :class => Course::GradingSystemEntity do
    association :grading_system, :factory => :course_grading_system
    sequence :name do |n|
      "Entity #{n}"
    end

    sequence :value do |n|
      n
    end
  end
end