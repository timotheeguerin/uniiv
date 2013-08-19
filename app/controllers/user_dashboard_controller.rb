class UserDashboardController < ApplicationController
  def index
    authorize! :read, current_user

    @university = current_user.university
    @faculty = current_user.faculty
    @programs = current_user.programs
  end
end
