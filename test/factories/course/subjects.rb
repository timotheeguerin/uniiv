# This will guess the User class
FactoryGirl.define do
  factory :course_subject, :class => Course::Subject do
    university
    name 'NAME'
  end
end