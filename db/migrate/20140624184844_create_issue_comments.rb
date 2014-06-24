class CreateIssueComments < ActiveRecord::Migration
  def change
    create_table :issue_comments do |t|
      t.references :issues, index: true
      t.references :commenter, index: true

      t.timestamps
    end
  end
end
