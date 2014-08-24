class User::AdvisorStudent < ActiveRecord::Base
  belongs_to :advisor, class_name: User::Advisor
  belongs_to :student, class_name: User::Student

  validates_uniqueness_of :student_id, scope: :advisor_id


  ##
  # Status of the mapping
  # Values:
  #   requested: When a user requested an advisor
  #   validated: When the request has been validated by the advisor or has been created by an advisor
  #   blacklisted: When an advisor blacklist a student he won't be able to request again
  #   removed:
  enum status: [:requested, :validated, :blacklisted, :removed]

  after_save :reindex
  after_destroy :reindex

  def reindex
    advisor.index unless advisor.nil?
    student.index unless student.nil?
  end
end
