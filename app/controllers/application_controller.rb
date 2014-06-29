class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_scenario, :current_scenario=, :current_term, :sign_in_as_other?, :real_current_user

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to main_app.root_url, :alert => exception.message
    else
      redirect_to main_app.new_user_session_path(:redirect => request.env['PATH_INFO'])
    end

  end

  protected

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
    if request.xhr?
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

  # Redirect to the given url or render json depending on the request
  # If the request is made using ajax it will render json otherwise redirect
  #   @param destination: Path to for redirection
  #   @param success: Boolean if the request was successful(Will change the type of flash)
  #   @param message: message to flash or send in json(Message need to be a key for translation)
  def redirect_or_json(destination: nil, success: true, message: '')
    if request.xhr?
      if params[:graph_embed]
        return_json(message, :url => destination, :success => success)
      else
        return_json(message, :success => success)
      end

    else
      flash_message(message, success)
      _redirect_to destination
    end
  end

  def render_or_json(options)
    success = options[:success]
    success ||= false
    message = options[:message]
    view = options[:view]
    if request.xhr?
      return_json(message, :url => destination, :success => success)
    else
      flash_message(message, success)
      render view
    end
  end

  def flash_message(message, success)
    if success
      flash[:notice] = t(message)
    else
      flash[:alert] = t(message)
    end
  end

  def real_current_user=(user)
    session[:real_current_user_id] = user.id
    @real_current_user=user
  end

  #Return the real user when he is sign in as another
  def real_current_user
    if @real_current_user.nil? and session.key?(:real_current_user_id)
      @real_current_user = User.find_by_id(session[:real_current_user_id])
    else
      @real_current_user = current_user
    end
    @real_current_user
  end

  #Tell if the current user is not the real current user
  def sign_in_as_other?
    !(@real_current_user.nil? and not session.key?(:real_current_user_id))
  end

  def sign_in_as(user)
    authorize! :sign_in_as, user
    sign_in :user, user
    self.real_current_user=self.real_current_user
  end

  #Sign back to the real_current_user
  def sign_back
    return unless sign_in_as_other?
    sign_in :user, self.real_current_user
    session.delete(:real_current_user_id)
    @real_current_user = nil
  end

  def object_id(object)
    "#{object.class}.#{object.id}"
  end

  def from_object_id(string)
    class_name, id = string.split('.')
    clazz = class_name.safe_constantize
    return nil if clazz.nil?
    clazz.find_by_id(id)
  end
end
