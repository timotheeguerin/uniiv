class Admin::Utils::CourseLoaderController < ApplicationController
  def new
    authorize! :create, Course::Course
    @url = ''
  end

  def load
    authorize! :create, Course::Course
    @url = params['url']
    if @url.nil?
      render :new
    else


      result = Utils::McgillCourseParser.parse_course(url)
      if result[:success]
        @course = result[:course]
      else
        flash[:notice] = result[:error]
      end
      render :new
    end
  end

  def load_all
    authorize! :create, Course::Course
    @hrefs = Utils::McgillCourseParser.parse_all
  end
end
