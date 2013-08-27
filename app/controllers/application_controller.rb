require 'utils/term'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_scenario, :current_scenario=, :current_term

  private
  def current_scenario
    unless session[:scenario_id].nil?
      @current_scenario ||= current_user.course_scenarios.find(session[:scenario_id])
    end
    if @current_scenario.nil?
      @current_scenario = current_user.main_course_scenario
      session[:scenario_id] = @current_scenario.id
    end
    @current_scenario
  end

  def current_scenario=(scenario)
    @current_scenario = scenario
    session[:scenario_id] = scenario.id
    scenario
  end

  def ge_path(path, ge = false)
    if ge
      path += '/graph/embed'
    end
    path
  end

  def current_term
    if @current_semester.nil?
      time = Time.now
      @current_semester = Term.new
      @course = Course::Course.find_by_name('kil')
      if time.month <= 4
        @current_semester.semester = Course::Semester.find_by_name('winter')
      elsif time.month <= 8
        @current_semester.semester = Course::Semester.find_by_name('summer')
      else
        @current_semester.semester = Course::Semester.find_by_name('fall')
      end
      @current_semester.year = time.year
    end
    @current_semester
  end

  def return_json(message, url = nil)
    json = {}
    json[:success] = true
    json[:message] = t(message)
    json[:url] = url unless url.nil?
    render :json => json.to_json
  end

  def _render(view)
    if params[:graph_embed]
      view += '_graph_embed'
      render view, :layout => false
    else
      render view
    end
  end
end
