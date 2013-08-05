class UserProgramsController < ApplicationController
  def show
    @programs = current_user.programs
  end

  def new
    @faculty = current_user.faculty  
  end

  def create
  end

  def delete
  end
end
