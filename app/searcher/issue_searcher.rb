class IssueSearcher

  # Search for issues
  def self.search(filters)
    search = Issue::Issue.search do
      fulltext filters[:q]
      with :status, Issue::Issue.statuses[filters[:status].to_s] unless filters[:status].blank?
      with :reporter_id, filters[:reporter_id] unless filters[:reporter_id].blank?
      with :assignee_id, filters[:assignee_id] unless filters[:assignee_id].blank?
      with :id, filters[:authorized_ids] unless filters[:authorized_ids].blank?
    end

    search.results
  end

  # Search for issue items
  def self.search_items(filters)
    search = Sunspot.search Course::Course, Program::Program do |query|
      query.fulltext filters[:q]
    end
    search.results
  end
end