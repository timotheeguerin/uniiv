# This will guess the Course class
FactoryGirl.define do
  factory :course_course, :class => Course::Course do
    association :subject, :factory => :course_subject
    name 'Course generated'
    sequence(:code)
    hours 3
    credit 3
    description 'Dumb description'
  end
end