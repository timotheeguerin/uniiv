# This will guess the Program::Program class
FactoryGirl.define do
  factory :program_program, :class => Program::Program do
    faculty
    association :type, :factory => :programs_type
    name 'Program generated'
  end
end