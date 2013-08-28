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
    university = University.find_by_name(params[:uni])
    if university.nil?
      redirect_to user_university_new_path, :alert => t('error.university.nil')
    end
    current_user.university = university
    current_user.save
    redirect_to user_education_path
  end

  def delete
    current_user.university = nil
    current_user.save
  end
end
