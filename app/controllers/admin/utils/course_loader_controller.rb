class Admin::Utils::CourseLoaderController < ApplicationController
  def new
    @url = ''
  end

  def load
    @url = params['url']
    if @url.nil?
      render :new
    else
      #DO the parsing of the page
    end
  end
end
