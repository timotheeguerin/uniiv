# This will guess the User::AdvisorStudent class
FactoryGirl.define do
  factory :user_advisor_student, class: 'User::AdvisorStudent' do
    association :student, :factory => :student
    association :advisor, :factory => :advisor
    status :validated
  end

end