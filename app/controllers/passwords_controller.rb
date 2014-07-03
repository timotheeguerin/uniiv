class PasswordsController < Devise::PasswordsController
  def new
    @fullwidth = true
    super
  end

  def create
    @fullwidth = true
    super
  end
end