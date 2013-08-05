class UserDashboardController < ApplicationController
  def index
    @university = current_user.university
    @faculty = current_user.faculty
    @programs = current_user.programs
  end
end
