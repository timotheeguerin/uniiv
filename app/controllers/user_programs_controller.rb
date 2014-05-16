class UserProgramsController < ApplicationController
  def show
    @programs = current_user.main_course_scenario.programs
  end

  def new
    authorize! :edit, current_user
    @faculty = current_user.faculty
    if @faculty.nil?
      redirect_to user_faculty_edit_path, :alert => t('error.faculty.notselected')
    end
  end

  def create
    authorize! :edit, current_user
    if current_user.main_course_scenario.programs.size > 6
      redirect_to user_education_path, :alert => t('error.program.maximum')
    else
      if params[:program_id].nil?
        redirect_to user_programs_new_path, :alert => t('error.program.nil')
      else
        program = Program::Program.find(params[:program_id])
        if program.nil?
          redirect_to user_programs_new_path, :alert => t('error.program.nil')
        elsif current_user.main_course_scenario.programs.include? program
          redirect_to user_programs_new_path, :alert => t('error.program.course_taking')
        else
          current_user.main_course_scenario.programs << program
          current_user.save
          redirect_to user_education_selection_path, :notice => t('program.add.success')
        end
      end
    end
  end

  def delete
    authorize! :edit, current_user
    program = Program::Program.find(params[:program_id])
    current_user.main_course_scenario.programs.delete(program)

    redirect_to user_education_path, :notice => t("program.remove.success")
  end
end
