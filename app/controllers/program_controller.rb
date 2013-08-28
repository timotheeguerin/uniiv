class ProgramController < ApplicationController
  def show
    @program = Program.find(params[:id])
  end

  def graph_embed
    @program = Program.find(params[:id])
    render :layout => false
  end

  def search_autocomplete
    programs = search
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    programs.each do |program|
      suggestion = {}
      suggestion[:value] = program.to_long_s
      suggestion[:data] = program.id
      suggestions << suggestion
    end
    render :json => json.to_json
  end

  def search
    limit = params[:limit]
    university_id = params[:university_id]
    faculty_id = params[:faculty_id]
    search = Program.search do
      fulltext params[:q]
      paginate(:page => 1, :per_page => limit) unless limit.nil?
      with :university_id, university_id unless university_id.nil?
      with :faculty_id, faculty_id unless faculty_id.nil?
    end
    search.results
  end
end
