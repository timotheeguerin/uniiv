class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    resource = build_resource(params[:user].permit(:email, :password, :password_confirmation))
    user_email = UserEmail.new
    user_email.email = resource.email
    user_email.primary = true
    user_email.validated = false
    resource.emails << user_email

    if resource.save
      puts 'save user'
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      render :action => 'new'
    end


  end

  def update
    super
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation) # And whatever other params you need
  end

end