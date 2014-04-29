class User::CourseController < ApplicationController
  before_action :setup

  def setup
    authorize! :edit, current_user
    @course = Course::Course.find(params[:course_id]) unless params[:course_id].nil?
    if @course.nil?
      if request.xhr?
        return_json('course.notfound', :success => false)
      else
        flash[:notice] = 'Course not found'
        _redirect_to :back
      end
    end
  end


  #Remove a course the user is taking or has completed
  def remove
    current_scenario.untake_course(@course)

    if request.xhr?
      return_json('course.untake', :url => course_graph_embed_path(@course))
    else
      _redirect_to :back
    end
  end
end