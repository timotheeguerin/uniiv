# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program_program_version, :class => 'Program::ProgramVersion' do
    program nil
  end
end
