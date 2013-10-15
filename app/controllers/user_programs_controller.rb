class UserProgramsController < ApplicationController
  def show
    @programs = current_user.main_course_scenario.programs
  end

  def new
    @faculty = current_user.faculty
    if @faculty.nil?
      redirect_to user_faculty_edit_path, :alert => t('error.faculty.notselected')
    end
  end

  def create
    if current_user.main_course_scenario.programs.size > 6
      redirect_to user_education_path, :alert => t('error.program.maximum')
    else
      if (params.has_key?("prog") and !params["prog"].nil? and params["prog"] != "")
        program = params[:prog]
        program = Program.find(params["prog"])
        puts program.nil?
        if program.nil?
          redirect_to user_programs_new_path, :alert => t('error.program.nil')
        elsif current_user.main_course_scenario.programs.include? program
          redirect_to user_programs_new_path, :alert => t('error.program.course_taking')
        else
          current_user.main_course_scenario.programs << program
          current_user.save
          redirect_to user_education_path, :notice => t("program.add.success")
        end
      else
        redirect_to user_programs_new_path, :alert => t('error.program.nil')
      end
    end
  end

  def removeProgram
    program = params["data-service"]
    program = Program.find(program)
    current_user.main_course_scenario.programs.delete(program)

    redirect_to user_education_path, :notice => t("program.remove.success")
  end
end
