class Search
  def initialize
    @limit = nil
    @query = nil
    @page = 1
    @params = {}
  end

  def self.from_params(params)
    search = Search.new
    search.limit = params[:limit]
    search.query = params[:query]
    search.page = params[:page]
    search.params = params
  end

  def [](key)
    params[key]
  end

  def search()

  end
end