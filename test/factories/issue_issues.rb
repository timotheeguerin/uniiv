# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue_issue, :class => Issue::Issue do
    title 'Issue generated'
    reporter nil
    assignee nil
  end
end
