class User::Advisor < User
  has_many :advisor_students, class_name: User::AdvisorStudent
  has_many :students, through: :advisor_students, class_name: User::Student
  has_many :assigned_issues, class_name: Issue::Issue, foreign_key: :assignee_id

  def student_with_most_issues
    User::Student.joins(:advisor_students).group('id').having('count(*) > 0').order('count(*) desc')
  end

  def remove_student(student)
    advisor_student = advisor_students.find_by_student_id(student.id)
    destroy_advisor_student(advisor_student)
  end

  def destroy_advisor_student(advisor_student, method = :blacklist)
    case method
      when :blacklist
        advisor_student.blacklisted!
        advisor_student.save
      else
        advisor_student.destroy
    end
  end

  searchable do
    integer :student_ids, multiple: true, references: User::Student
  end

end