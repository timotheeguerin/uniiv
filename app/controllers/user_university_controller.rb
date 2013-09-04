class UserUniversityController < ApplicationController
  def show
    @current_university = current_user.university
  end

  def new
  end

  def create
    university = University.find(params[:id])
    current_user.university = university
    current_user.save
  end

  def edit
    @current_university = current_user.university
  end

  def update
    university = University.find(params[:uni])
    if university.nil?
      redirect_to user_university_edit_path, :alert => t('error.university.nil')
    else
      current_user.university = university
      current_user.save
      redirect_to user_education_path
    end
  end

  def delete
    current_user.university = nil
    current_user.save
  end
end
