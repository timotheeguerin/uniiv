# This will guess the Course class
FactoryGirl.define do
  factory :course_subject_course_list, class: Course::SubjectCourseList do
    association :subject, :factory => :course_subject
    association :group, :factory => :program_group
    level 200
    operation 'LESS'
  end
end