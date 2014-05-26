class SwitchUserController < ApplicationController
  def select_switch
    render :switch
  end

  def switch
    user = User.find(params[:user_id])
    begin
      sign_in_as(user)
      flash[:notice] = t('switch_user.success', user.to_s)
      redirect_to root_path
    rescue CanCan::AccessDenied
      flash[:alert] = t('switch_user.permission.error')
    end
  end

  def switch_back
    sign_back
    flash[:notice] = t('switch_user.back.success')
    redirect_to switch_user_path
  end

  def search
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    search = User.search do
      fulltext params[:q]
    end
    search.results.each do |user|
      suggestion = {}
      suggestion[:value] = user.primary_email.to_s
      suggestion[:data] = user.id
      suggestions << suggestion
    end
    render :json => json.to_json
  end
end
