class ChangeValidatedToStatusInAdvisorStudents < ActiveRecord::Migration
  def up
    rename_column :user_advisor_students, :validated, :status
    change_column :user_advisor_students, :status, :integer, default: 0
  end

  def down
    rename_column :user_advisor_students, :status, :validated
    change_column :user_advisor_students, :validated, :boolean, default: false
  end
end
