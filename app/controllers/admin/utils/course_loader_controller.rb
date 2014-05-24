class Admin::Utils::CourseLoaderController < ApplicationController
  def new
    authorize! :create, Course::Course
    @url = ''
    @result = nil
  end

  def load
    authorize! :create, Course::Course
    @url = params['url']
    @result = nil
    if @url.nil?
      render :new
    else
      begin
        @result = Utils::McgillCourseParser.load_course_from_url(@url)
      rescue => e
         flash[:alert] = "#{e.class.name.demodulize} : #{e.message}"
      end
      render :new
    end
  end

  def load_all
    authorize! :create, Course::Course
    @hrefs = Utils::McgillCourseParser.parse_all
  end
end
