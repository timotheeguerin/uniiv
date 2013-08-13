class Program < ActiveRecord::Base
  belongs_to :type, :class_name => ProgramsType
  belongs_to :faculty, :class_name => Faculty
  has_many :groups, :class_name => ProgramGroup, :as => :groupparent

  def to_s
    name.to_s+ " (#{type.to_s.capitalize})"
  end

  def get_completion_ratio(user)
    puts "HELLO--------------------------------------------"
    ratio = 0
    groups.each do |group|
      ratio += group.get_completion_ratio(user)
      count += 1
    end
    puts "------------------------------------------"
    puts ratio
    puts count
    ratio / count
  end

  def id_to_s
    'p_' + id.to_s
  end
end
