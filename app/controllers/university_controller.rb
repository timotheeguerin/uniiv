class UniversityController < ApplicationController
  def search_autocomplete
    universities = search
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    universities.each do |university|
      suggestion = {}
      suggestion[:value] = university.to_s
      suggestion[:data] = university.id
      suggestions << suggestion
    end
    render :json => json.to_json
  end

  private
  def search
    limit = params[:limit]
    search = University.search do
      fulltext params[:q]
      paginate(:page => 1, :per_page => limit) unless limit.nil?
    end
    search.results
  end
end
