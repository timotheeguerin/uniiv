# This will guess the User class
FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test.#{n}@testing.com"
    end
    password 'superpassword'

    after(:create) do |object|
      create(:course_main_scenario,  :user => object)
    end
  end
end