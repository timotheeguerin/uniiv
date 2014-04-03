class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      render 'user_dashboard/index'
    else
      @fullwidth = true
    end
  end

  def header
    render :partial => 'layouts/navigation'
  end
end
