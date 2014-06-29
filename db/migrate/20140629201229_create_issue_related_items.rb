class CreateIssueRelatedItems < ActiveRecord::Migration
  def change
    create_table :issue_related_items do |t|
      t.references :issue, index: true
      t.references :item, polymorphic: true, index: true

      t.timestamps
    end
  end
end
