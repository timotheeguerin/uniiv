# This will guess the UserTakingCourse class
FactoryGirl.define do
  factory :user_taking_course do
    association :semester, :factory => :course_semester
    year 2014
    course_scenario
    association :course, :factory => :course_course
  end
end