class Issue::Comment < ActiveRecord::Base
  belongs_to :issue, :class_name => Issue::Issue
  belongs_to :commenter, :class_name => User
  has_one :content, :class_name => RichContent, :as => :contentable, :dependent => :destroy

  validates_presence_of :issue_id
  validates_presence_of :commenter_id

  accepts_nested_attributes_for :content


end
