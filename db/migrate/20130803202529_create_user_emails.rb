class CreateUserEmails < ActiveRecord::Migration
  def change
    create_table :user_emails do |t|
      t.string :email
      t.boolean :validated
      t.boolean :primary
      t.references :university, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
