# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_invite, :class => 'User::Invite' do
    message 'Super message'
    key 'My super key'
    amount 10
    used 1
    category 'User::Advisor'
  end
end
