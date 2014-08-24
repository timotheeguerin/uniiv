# This will guess the UserCompletedCourse class
FactoryGirl.define do
  factory :user_completed_course do
    association :semester, :factory => :course_semester
    association :grade, :factory => :course_grading_system_entity
    year 2014
    user
    association :course, :factory => :course_course

    factory :user_advenced_standing do
      advanced_standing true
    end
  end
end