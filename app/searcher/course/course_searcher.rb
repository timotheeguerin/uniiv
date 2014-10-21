class Course::CourseSearcher < ApplicationSearcher
  def self.search(filters)
    scenario = Course::Scenario.find(filters[:scenario_id])
    search = Course::Course.search do
      fulltext filters[:q] if filters[:q]
      paginate(page: 1, per_page: filters[:limit]) unless filters[:limit].nil?
      unless scenario.nil?
        without(:course_scenario_ids, scenario.id) if filters[:only_not_taking]
        with(:course_scenario_ids, scenario.id) if filters[:only_taking]
        without(:user_ids, scenario.user.id) if filters[:only_not_completed]
        with(:user_ids, scenario.user.id) if filters[:only_completed]
      end
      with(:program_group_ids, filters[:program_groups]) if filters[:program_groups]
      with(:program_ids, filters[:program]) if filters[:program]
    end
    search.results
  end
end