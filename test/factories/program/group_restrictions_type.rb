# This will guess the Program::Program class
FactoryGirl.define do
  factory :program_group_restriction_type, :class => Program::Group::RestrictionType do
    name 'Type'
  end
end