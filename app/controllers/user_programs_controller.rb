class UserProgramsController < ApplicationController

  def new
    authorize! :edit, current_user
    @faculty = current_user.faculty
    if @faculty.nil?
      redirect_to user_faculty_edit_path, :alert => t('error.faculty.notselected')
    end
  end

  def select_version
    versions = []
    if params.has_key?(:program_id)
      program = Program::Program.find(params[:program_id])
      versions = program.versions
    end
    render :partial => 'user_programs/select_version', :locals => {:versions => versions}
  end

  def create
    authorize! :edit, current_user
    if current_user.main_course_scenario.reached_max_programs?
      redirect_to user_education_path, :alert => t('error.program.maximum')
    else
      program = Program::Program.find(params[:program_id])
      if params[:version_id].nil? or params[:version_id].blank?
        version = program.versions.last
      else
        version = program.versions.find(params[:version_id])
      end

      redirect_to user_programs_new_path, :alert => t('error.version.nil') if version.nil?
      current_user.main_course_scenario.programs << version
      current_user.save
      redirect_to user_education_selection_path, :notice => t('program.add.success')
    end
  end


  def delete
    authorize! :edit, current_user
    version = if params.key?(:version_id)
                Program::Version.find(params[:version_id])
              elsif params.key?(:program_id)
                Program::Program.find(params[:program_id]).versions.last
              else
                raise ActiveRecord::RecordNotFound
              end
    current_user.main_course_scenario.programs.delete(version)

    redirect_to user_education_selection_path, :notice => t('program.remove.success')
  end

end
