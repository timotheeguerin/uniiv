class WelcomeController < ApplicationController
  def index
    @fullwidth = true
    return unless user_signed_in?
    if current_user.advisor?
      redirect_to advisor_dashboard_path
    elsif current_user.student?
      redirect_to user_education_path
    else
      flash[:error] = 'There is an error with your account!'
    end
  end

  def header
    render :partial => 'layouts/navigation'
  end
end
