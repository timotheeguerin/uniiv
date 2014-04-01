class Program::GroupRestriction < ActiveRecord::Base
  belongs_to :group, :class_name => Program::Group
  belongs_to :type, :class_name => Program::GroupRestrictionType

  validates_presence_of :group_id
  validates_presence_of :type_id

  before_save :default_values

  def default_values
    self.value ||= 0 unless type.name == 'all'
  end

  def get_completition_ratio(scenario, term = nil)
    case type.name
      when 'min_credit'
        puts 'MIN CRREDI'
        compute_ratio(group.count_credit_completed_courses(scenario, term), value)
      when 'min_grp'
        return Utils::Ratio.full if value == 0
        ratios = group.get_subgroups_completed_ratio(scenario, term).sort()
        ratio = ratios[0...value].inject { |sum, x| sum + x }
        compute_ratio(ratio, value)
      else #Complete all
        count = group.count_completed_courses(scenario, term)
        total_course = group.count_all_courses
        total_credit = group.count_total_credit
        Utils::Ratio.new(count.to_f/total_course.to_f, total_credit)
    end
  end

  def compute_ratio(count, goal)
    if count > goal or goal == 0
      Utils::Ratio.full(goal)
    else
      Utils::Ratio.from_value(count.to_f, goal.to_f)
    end
  end
end
