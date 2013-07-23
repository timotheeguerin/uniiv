class ProgramGroup < ActiveRecord::Base
  belongs_to :type
  belongs_to :parent
end
