class User::AdvisorStudent < ActiveRecord::Base
  belongs_to :advisor, class_name: User::Advisor
  belongs_to :student, class_name: User::Student
end
