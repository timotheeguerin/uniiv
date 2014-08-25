class Program::Group::RestrictionType < ActiveRecord::Base
  def to_s
    name
  end
end

