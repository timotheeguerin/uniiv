# This will guess the User class
FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test.#{n}@testing.com"
    end
    password 'superpassword'
    university
    first_name 'John'
    last_name 'Smith'
    type 'User'
    advanced_standing_credits 0

    after(:create) do |object|
      create(:course_main_scenario, :user => object)
    end
  end

  factory :student, parent: :user, class: 'User::Student' do
    type 'User::Student'
  end
  factory :advisor, parent: :user, class: 'User::Advisor' do
    type 'User::Advisor'
  end
end