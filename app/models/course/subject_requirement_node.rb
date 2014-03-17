class Course::SubjectRequirementNode < ActiveRecord::Base
  belongs_to :subject
  belongs_to :node

  def to_s
    "#{amount} in #{subject} at level #{level}"
  end
end
