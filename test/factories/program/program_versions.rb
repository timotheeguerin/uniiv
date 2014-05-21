# This will guess the Program::Program class
FactoryGirl.define do
  factory :program_program_version, :class => Program::Version do
    association :program, :factory => :program_program
    start_year 2010
    end_year 2011
  end
end