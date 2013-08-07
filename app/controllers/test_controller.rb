class TestController < ApplicationController
  def index
    if current_user.university.nil?
      redirect_to user_university_edit_path, :alert => t("error.university.notselected")
    elsif current_user.faculty.nil?
      redirect_to user_faculty_edit_path, :alert => t("error.faculty.notselected")
    elsif current_user.programs.empty?
      redirect_to user_programs_new_path, :alert => t("error.programs.notselected")
    else
    
    end
    
  end
end
