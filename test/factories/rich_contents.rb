# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rich_content do
    text 'Some rich content **text**'
    format :markdown
  end
end
