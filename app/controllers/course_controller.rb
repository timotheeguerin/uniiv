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
    @courses = search_course(params[:q])
    render :layout => false
  end

  def search_json
    courses = search_course(params[:q])
    json =[]
    courses.each do |course|
      json << course
    end
    render :json => json.to_json
  end

  def search_course(query)
    search = Course::Course.search do
      fulltext query
    end
    search.results
  end
end