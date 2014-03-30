class CreateContactusForms < ActiveRecord::Migration
  def change
    create_table :contactus_forms do |t|
      t.string :email
      t.text :content

      t.timestamps
    end
  end
end
