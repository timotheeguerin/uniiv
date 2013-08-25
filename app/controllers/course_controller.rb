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


  def search_json
    courses = search_course
    json =[]
    courses.each do |course|
      json << course
    end
    render :json => json.to_json
  end

  def search_course
    search = Course::Course.search do
      fulltext 'math 2013'
    end
    search.results
  end
end