class UserCoursesController < ApplicationController
  def index
    if current_user.nil?
      redirect_to :status => 404
    end
  end
end
