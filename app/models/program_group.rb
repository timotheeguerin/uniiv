class ProgramGroup < ActiveRecord::Base
  belongs_to :groupparent, :polymorphic => true
  has_many :subgroups, :class_name => ProgramGroup, :as => :groupparent
  has_and_belongs_to_many :courses, :class_name => Course

  def restriction_enum
    ['all', 'min_nb', 'min_credit']
  end
end
