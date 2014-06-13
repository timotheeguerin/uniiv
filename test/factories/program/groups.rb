# This will guess the Program::Program class
FactoryGirl.define do
  factory :program_group, :class => Program::Group do
    association :groupparent, :factory => :program_version
    name 'Program group'

    factory :program_group_subgroup do
      association :groupparent, :factory => :program_group
    end
  end
end