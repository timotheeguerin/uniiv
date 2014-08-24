# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue_related_item, :class => 'Issue::RelatedItem' do
    issue nil
    item nil
  end
end
