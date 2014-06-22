# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rich_content do
    text "MyText"
    format 1
    contentable nil
  end
end
