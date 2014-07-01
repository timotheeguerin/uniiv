class User::Student < User
  has_many :advisor_students, class_name: User::AdvisorStudent
  has_many :advisors, through: :advisor_students

  #Return if the student already requested an advisor
  def has_an_advisor?
    advisors.any?
  end
end