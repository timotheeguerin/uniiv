class RichContent < ActiveRecord::Base
  belongs_to :contentable, polymorphic: true

  enum :format => [:markdown]

  # validates_presence_of :contentable_id
  # validates_presence_of :contentable_type
  validates_presence_of :format

  def to_html
    config = {
        :markdown => Utils::RichContent::Markdown,
        :bullshit => true
    }

    config[format.to_sym].to_html(text ? text : '')
  end

  def to_s
    to_html
  end
end
