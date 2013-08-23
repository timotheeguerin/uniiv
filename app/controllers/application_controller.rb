class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_scenario

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

  def ge_path(path, ge = false)
    if ge
      path += '/graph/embed'
    end
    path
  end
end
