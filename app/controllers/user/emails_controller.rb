class User::EmailsController < ApplicationController

  before_action :setup

  def setup
    authorize! :edit, current_user
  end

  def index

  end

  def create
    email = UserEmail.new
    email.user = current_user
    email.email = params[:email]
    if email.save
      flash[:notice] = t('useremail.add')
    else
      flash[:alert] = t('useremail.duplicate')
    end
    redirect_to user_settings_index_path
  end

  def set_as_default
    email = UserEmail.find(params[:email])
    user = email.user
    user.email = email.email
    user.emails.each do |e|
      e.primary = false
      e.save
    end
    email.primary = true
    email.save
    user.save
    flash[:notice] = t('useremail.makedefault')
    redirect_to user_settings_index_path
  end

  def remove
    email = UserEmail.find(params[:email])
    if email.primary?
      flash[:notice] = t('useremail.delete.primary.error')
    else
      flash[:notice] = t('useremail.remove')
      email.destroy
    end

    redirect_to user_settings_index_path
  end

end
