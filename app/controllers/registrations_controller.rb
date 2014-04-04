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

    user_role = Role.find_by_name('user')

    user.roles << user_role

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

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource(resource, account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      flash[:notice] = t('user.password.update.success')
      respond_with resource, location: user_settings_index_path
    else
      clean_up_passwords resource
      flash[:alert] = resource.errors.full_messages.first
      redirect_to user_settings_index_path
    end
  end

  def destroy
    self.resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    redirect_to root_path, :notice => 'Account removed with succces!'
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation) # And whatever other params you need
  end

end