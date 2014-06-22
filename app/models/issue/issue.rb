class Issue::Issue < ActiveRecord::Base
  has_one :content, :class_name => RichContent, :as => :contentable, :dependent => :destroy
  belongs_to :reporter, :class_name => User
  belongs_to :assignee, :class_name => User

  validates_presence_of :reporter_id
  validates_presence_of :title
  validates_length_of :title, :minimum => 5, :maximum => 100

  accepts_nested_attributes_for :content
end
