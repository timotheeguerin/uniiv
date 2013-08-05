class UserFacultyController < ApplicationController
  def show

  end

  def new
  end

  def create
    faculty = Faculty.find(params[:id])
    current_user.faculty = faculty
    current_user.save
  end

  def edit
    @university = current_user.university
    @current_faculty = current_user.faculty
  end

  def update
    faculty = Faculty.find(params[:id])
    current_user.faculty = faculty
    current_user.save
  end

  def delete
    current_user.faculty = nil
    current_user.save
  end
end
