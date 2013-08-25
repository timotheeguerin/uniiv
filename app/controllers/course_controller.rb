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
    courses = search_course2
    json =[]
    courses.each do |course|
      json << course.to_s
    end
    render :json => json.to_json
  end

  def search_course
    query = params[:query]
    words = query.split(' ')
    courses = {}
    queries = []

    words.each do |word|
      like = "%#{word}%"
      results = Course::Course.joins(:subject).where { (subject.name =~ like) | (code =~ word) | (name =~ like) }
      results.each do |row|
        courses[row] ||= 0
        courses[row] += 1
      end
    end
    courses.sort_by { |course, value| -value }
  end

  def search_course2
    search = Course::Course.search do
      fulltext 'math 2013'
    end
    puts 'NV: ' + search.total.to_s
    search.results
  end
end