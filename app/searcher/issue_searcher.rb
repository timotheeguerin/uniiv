class IssueSearcher

  # Search for issues
  def self.search(filters)
    search = Issue::Issue.search do
      fulltext filters[:q]
      with :status, Issue::Issue.statuses[filters[:status].to_s] if filters[:status]
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