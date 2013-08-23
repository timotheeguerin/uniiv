class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    user = build_resource(params[:user].permit(:email, :password, :password_confirmation))
    user_email = UserEmail.new
    user_email.email = resource.email
    user_email.primary = true
    user_email.validated = false
    user.emails << user_email

    #Alpa
    alpha_tester_role = Role.find_by_name('AlphaTester')

    user.roles << alpha_tester_role

    scenario = Course::Scenario.new
    scenario.main = true
    user.main_course_scenario = scenario


    if resource.save
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      render :action => 'new'
    end
  end

  def after_sign_up_path_for(ressource)
    user_dashboard_index_path
  end

  def update
    super
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation) # And whatever other params you need
  end

end