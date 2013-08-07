class UserProgramsController < ApplicationController
  def show
    @programs = current_user.programs
  end

  def new
    @faculty = current_user.faculty
     if @faculty.nil?
      redirect_to user_faculty_edit_path, :alert => t('error.faculty.notselected')
    end
  end

  def create
    program = Program.find_by_name(params[:prog])
    if program.nil?
      redirect_to user_programs_new_path, :alert => t('error.program.nil')
    end
    if current_user.programs.include? program
      redirect_to user_programs_new_path, :alert => t('error.program.taking')
    else
      current_user.programs << program
      current_user.save
      redirect_to user_dashboard_index_path
    end
    
  end

  def delete
  end
end
