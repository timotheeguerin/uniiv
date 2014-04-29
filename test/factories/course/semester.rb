# This will guess the Course::Semester class
FactoryGirl.define do
  factory :course_semester, :class => Course::Semester do
    name 'FALL'
  end
end