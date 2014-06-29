class IssueSearcher
  def self.search_items(params)
    search = Sunspot.search Course::Course, Program::Program do |query|
      query.fulltext params[:q]
    end
    search.results
  end
end