# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue_issue, :class => Issue::Issue do
    title 'Issue generated'
    association :reporter, :factory => :user
    association :assignee, :factory => :user

    after(:create) do |object|
      create(:rich_content, :contentable => object)
    end
  end
end
