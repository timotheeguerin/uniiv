class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_scenario

  private
  def current_scenario
    @current_scenario ||= current_user.course_scenarios.find(session[:senario_id])
    if @current_scenario.nil?
      @current_scenario = current_user.main_course_scenario
      session[:senario_id] = @current_scenario.id
    end
  end
end
