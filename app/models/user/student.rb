class User::Student < User
  has_many :advisor_students, class_name: User::AdvisorStudent
  has_many :advisors, through: :advisor_students
  has_many :issues, class_name: Issue::Issue, foreign_key: :reporter_id

  #Return if the student already requested an advisor
  def has_an_advisor?
    advisors.any?
  end

  def remove_advisor(advisor)
    advisor_student = advisor_students.find_by_advisor_id(advisor.id)
    destroy_advisor_student(advisor_student)
  end

  def destroy_advisor_student(advisor_student)
    advisor_student.removed!
    advisor_student.save
  end
end