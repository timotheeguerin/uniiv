# This will guess the User class
FactoryGirl.define do
  factory :user_email do
    user
    primary false
    validated true
    sequence :email do |n|
      "user-#{n}@email.com"
    end
  end
end