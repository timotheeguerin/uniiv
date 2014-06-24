# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue_comment, :class => 'Issue::Comment' do
    issue nil
    commenter nil
  end
end
