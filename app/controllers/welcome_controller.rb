class WelcomeController < ApplicationController
  def index
    @fullwidth = true
  end

  def header
    render :partial => 'layouts/navigation'
  end
end
