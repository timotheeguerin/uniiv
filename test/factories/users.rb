# This will guess the User class
FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'superpassword'

    after(:create) do |object|
      create(:course_main_scenario,  :user => object)
    end
  end
end