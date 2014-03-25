# This will guess the User class
FactoryGirl.define do
  factory :course_grading_system, :class => Course::GradingSystem do
    name 'Test grading scheme'

    ignore do
      entity_count 5
    end
    after(:create) do |object, evaluator|
      create_list(:course_grading_system_entity, evaluator.entity_count, :grading_system => object)
    end
  end
end