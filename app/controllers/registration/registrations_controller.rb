class Registration::RegistrationsController < Devise::RegistrationsController
  def new
    setup_new
    super
  end

  def create
    user = build_resource(resource_params)
    build_email(user)

    user.type = User::Student.to_s
    user.add_role(:user)
    user.reset
    invite = handle_invite(user)
    if invite != false and user.save
      invite.save if invite
      sign_in(resource_name, user)
      respond_with resource, :location => after_sign_up_path_for(user)
    else
      @fullwidth = true
      render :new
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  private

  def build_email(user)
    user_email = UserEmail.new
    user_email.email = resource.email
    user_email.primary = true
    user_email.validated = false
    user.emails << user_email
  end

  def handle_invite(user)
    invite = User::Invite.find_by_key(params[:invite_key])
    return nil if invite.nil?
    invite.use
    unless invite.valid?
      invite.errors.full_messages.each do |error|
        user.errors[:base] << error
      end
      return false
    end
    case invite.category
      when 'User::Advisor'
        user.type = 'User::Advisor'
      else
        return nil
    end
    invite
  end

  def setup_new
    @fullwidth = true
    if params[:invite_key]
      invite = User::Invite.find_by_key(params[:invite_key])
      if invite.nil?
        flash[:alert] = t('signup.invite_key.error.not_found', key: params[:invite_key])
      else
        flash[:info] = t('signup.invite_key.notice', key: invite.message)
      end
    end
  end
end