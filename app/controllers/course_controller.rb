class CourseController < ApplicationController

  def show
    @course = Course::Course.find(params[:id])
  end

  def graph_embed
    @course = Course::Course.find(params[:id])
    render :layout => false
  end

  def json
    course = Course::Course.find(params[:id])
    render :json => course.as_json
  end

  def search_list
    result = search_course
    #@courses = check_courses(result)
    @courses = result
    render :layout => false
  end

  def search_json
    courses = search_course
    render :json => courses.to_json
  end

  def search_autocomplete
    courses = search_course
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    courses.each do |course|
      suggestion = {}
      suggestion[:value] = course.to_s + ' ' + course.name
      suggestion[:data] = course.id
      suggestions << suggestion
    end
    render :json => json.to_json
  end

  def search_course
    limit = params[:limit]
    search = Course::Course.search do
      fulltext params[:q]
      paginate(:page => 1, :per_page => limit) unless limit.nil?
      without(:course_scenario_ids, current_scenario.id) if params[:only_not_taking]
      with(:course_scenario_ids, current_scenario.id) if params[:only_taking]
      without(:user_ids, current_user.id) if params[:only_not_completed]
      with(:user_uds, current_user.id) if params[:only_completed]
    end
    search.results
  end
end