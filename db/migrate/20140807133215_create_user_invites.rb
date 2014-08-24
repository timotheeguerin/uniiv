class CreateUserInvites < ActiveRecord::Migration
  def change
    create_table :user_invites do |t|
      t.string :key
      t.integer :amount, default: 1
      t.integer :used, default: 0
      t.string :category
      t.string :message
      t.timestamps
    end
  end
end
