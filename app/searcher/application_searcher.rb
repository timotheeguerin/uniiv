class ApplicationSearcher

  attr_accessor :limit, :query, :page, :filters, :results

  def initialize(filters)
    @limit = filters[:limit]
    @query = filters[:q]
    @page = filters[:page]
    @filters = filters
    @results = []
  end

  def [](key)
    params[key]
  end

  protected
  def init_search(search)
    search.fulltext @filters[:q]
    if @page or @limit
      paginate_params = {}
      paginate_params[:page] = @page if @page
      paginate_params[:limit] = @limit if @limit
      search.paginate(paginate_params)
    end
  end
end