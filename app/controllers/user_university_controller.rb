class UserUniversityController < ApplicationController
  def show
  end

  def new
  end

  def create
    university = University.find(dparams[:id])
    current_user.university = university
    current_user.save  
  end

  def edit
    @current_university = current_user.university
  end

  def update
    university = University.find(dparams[:id])
    current_user.university = university
    current_user.save
  end

  def delete
    current_user.university = nil
    current_user.save
  end
end
