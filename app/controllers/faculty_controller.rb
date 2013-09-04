class FacultyController < ApplicationController
  def search_autocomplete
    faculties = search
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    faculties.each do |faculty|
      suggestion = {}
      suggestion[:value] = faculty.to_s
      suggestion[:data] = faculty.id
      suggestions << suggestion
    end
    render :json => json.to_json
  end

  def search
    limit = params[:limit]
    university_id = params[:university_id]
    search = Faculty.search do
      fulltext params[:q]
      paginate(:page => 1, :per_page => limit) unless limit.nil?
      with :university_id, university_id unless university_id.nil?
    end
    search.results
  end
end
