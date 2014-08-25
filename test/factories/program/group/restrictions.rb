# This will guess the Program::Program class
FactoryGirl.define do
  factory :program_group_restriction, :class => Program::Group::Restriction do
    association :group, :factory => :program_group
    association :type, :factory => :program_group_restriction_type
  end
end