module Utils
  class Search

    attr_accessor :limit, :query, :page, :params, :results

    def initialize
      @limit = nil
      @query = nil
      @page = 1
      @params = {}
      @results = []
    end

    def self.from_params(params)
      search = Utils::Search.new
      search.limit = params[:limit] unless params[:limit].nil?
      search.query = params[:q] unless params[:q].nil?
      search.page = params[:page] unless params[:page].nil?
      search.params = params
      search
    end


    def [](key)
      params[key]
    end

    def setup_search(s)
      s.fulltext @query
      s.paginate(:page => @page, :per_page => limit) unless limit.nil?
    end
  end

end