class UserUniversityController < ApplicationController
  def show
    @current_university = current_user.university
  end

  def edit
    authorize! :edit, current_user
    @current_university = current_user.university
  end

  def update
    authorize! :edit, current_user
    university = University.find(params[:university_id])
    current_user.university = university
    current_user.faculty = nil
    current_user.reset
    current_user.save
    redirect_to user_education_selection_path
  end

  #This will delete the user university and all its relation(courses taken,...)
  def delete
    current_user.university = nil
    current_user.save
  end
end
