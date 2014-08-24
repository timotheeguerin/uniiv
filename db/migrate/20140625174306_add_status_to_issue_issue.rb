class AddStatusToIssueIssue < ActiveRecord::Migration
  def change
    add_column :issue_issues, :status, :integer, default: 0
  end
end
