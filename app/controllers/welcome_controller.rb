class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_education_path
    else
      @fullwidth = true
    end
  end

  def header
    render :partial => 'layouts/navigation'
  end
end
