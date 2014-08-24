class CreateUserAdvisorStudents < ActiveRecord::Migration
  def change
    create_table :user_advisor_students do |t|
      t.references :advisor, index: true
      t.references :student, index: true
      t.boolean :validated, default: false

      t.timestamps
    end
  end
end
