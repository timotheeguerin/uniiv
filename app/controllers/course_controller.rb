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
    result = search_course(params[:query], 5)
    #@courses = check_courses(result)
    @courses = result
    render :layout => false
  end

  def search_json
    courses = search_course(params[:query])
    render :json => courses.to_json
  end

  def search_course(query, limit = nil)
    search = Course::Course.search do
      fulltext query
      paginate(:page => 1, :per_page => limit) unless limit.nil?
      without(:course_scenario_ids, current_scenario.id) if params[:only_not_taking]
      with(:course_scenario_ids, current_scenario.id) if params[:only_taking]
    end
    search.results
  end
end