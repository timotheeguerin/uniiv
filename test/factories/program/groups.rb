# This will guess the Program::Program class
FactoryGirl.define do
  factory :program_group, :class => Program::Group do
    association :parent, :factory => :program_version
    name 'Program group'

    factory :program_group_subgroup do
      association :parent, :factory => :group
    end
  end
end