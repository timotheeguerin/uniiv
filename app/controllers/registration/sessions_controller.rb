class Registration::SessionsController < Devise::SessionsController
  def new
    @fullwidth = true
    super
  end

  def create
    @fullwidth = true
    super
  end
end