class Issue::RelatedItem < ActiveRecord::Base
  belongs_to :issue, class_name: Issue::Issue
  belongs_to :item, polymorphic: true

  validates_presence_of :issue_id
  validates_uniqueness_of :item_id, scope: [:item_type, :issue_id]
end
