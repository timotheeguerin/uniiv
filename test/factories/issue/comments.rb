# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue_comment, :class => 'Issue::Comment' do
    association :issue, :factory => :issue_issue
    association :commenter, :factory => :user

    after(:create) do |object|
      create(:rich_content, :contentable => object)
    end
  end
end
