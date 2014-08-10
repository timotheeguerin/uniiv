class Issue::Issue < ActiveRecord::Base
  has_one :content, :class_name => RichContent, :as => :contentable, :dependent => :destroy
  belongs_to :reporter, :class_name => User
  belongs_to :assignee, :class_name => User
  has_many :comments, :class_name => Issue::Comment, :dependent => :destroy
  has_many :related_items, class_name: Issue::RelatedItem, dependent: :destroy
  enum status: [:open, :close]

  validates_presence_of :reporter_id
  validates_presence_of :title
  validates_length_of :title, :minimum => 5, :maximum => 100

  accepts_nested_attributes_for :content

  before_save do
    next if @related_items_str.nil? or @related_items_str == related_items.map{|x| Utils.element_id(x.item)}.join(',')
    self.related_items.destroy_all
    @related_items_str.split(',').map { |x| Utils.from_element_id(x) }.each do |item|
      self.related_items.build(item: item)
    end
  end

  def build_new_comment
    comment = Issue::Comment.new
    comment.issue = self
    comment.build_content
    comment
  end

  def status_inverse
    open? ? :close : :open
  end

  def related_items_str
    if @related_items_str.nil?
      @related_items_str = related_items.map{|x| Utils.element_id(x.item)}.join(',')
    end
    @related_items_str
  end

  def related_items_str=(str)
    @related_items_str=str
  end

  searchable do
    integer :id
    text :title
    integer :status do
      Issue::Issue.statuses[status]
    end
    integer :reporter_id
    integer :assignee_id
  end
end
