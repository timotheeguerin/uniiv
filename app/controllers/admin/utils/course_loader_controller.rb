class Admin::Utils::CourseLoaderController < ApplicationController
  def new
    @url = ''
  end

  def load
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
    @hrefs = Utils::McgillCourseParser.parse_all
  end
end
