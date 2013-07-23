class CourseSubject < ActiveRecord::Base
  belongs_to :university
  def to_s
    name
  end
end
