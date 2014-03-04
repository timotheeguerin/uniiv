class UserUniversityController < ApplicationController
  def show
    @current_university = current_user.university
  end

  def edit
    @current_university = current_user.university
  end

  def update
    university = University.find(params[:university_id])
    current_user.university = university
    current_user.save
    redirect_to user_education_path
  end

  #This will delete the user university and all its relation(courses taken,...)
  def delete
    current_user.university = nil
    current_user.save
  end
end
