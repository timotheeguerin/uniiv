# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_advisor_student, :class => 'User::AdvisorStudent' do
    advisor nil
    student nil
    validated false
  end
end
