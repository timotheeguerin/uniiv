class User::Advisor < User
  has_many :advisor_students, class_name: User::AdvisorStudent
  has_many :students, through: :advisor_students
end