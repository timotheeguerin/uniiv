# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_invite, :class => 'User::Invite' do
    key "MyString"
    amount 1
    used 1
    type ""
  end
end
