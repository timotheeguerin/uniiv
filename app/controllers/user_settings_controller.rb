class UserSettingsController < ApplicationController
  def index
    authorize! :edit, current_user
  end
end
