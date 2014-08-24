class CreateIssueIssues < ActiveRecord::Migration
  def change
    create_table :issue_issues do |t|
      t.string :title
      t.references :reporter, index: true
      t.references :assignee, index: true

      t.timestamps
    end
  end
end
