class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_scenario, :current_scenario=, :current_term

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to main_app.root_url, :alert => exception.message
    else
      redirect_to main_app.new_user_session_path(:redirect => request.env['PATH_INFO'])
    end

  end

  private

  def after_sign_in_path_for(ressource)
    get_redirect_path(user_education_path)
  end
  def after_sign_up_path_for(ressource)
    get_redirect_path(user_education_path)
  end

  def current_scenario
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
      @current_semester = Utils::Term::now
    end
    @current_semester
  end

  def return_json(message, options ={})
    json = {}
    json[:success] = options[:success]
    json[:success] ||= true
    json[:message] = t(message)
    json = json.merge(options)
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

  #Redirect to the path given in the url if it exist otherwise to the path given as parameter.
  # If parameter empty return to back
  def _redirect_to(path=nil)
    redirect_to get_redirect_path(path)
  end

  def get_redirect_path(path = nil)
    if params[:redirect].nil?
      if path.nil?
        :back
      else
        path
      end
    else
       params[:redirect]
    end
  end
end
