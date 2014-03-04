class UserFacultyController < ApplicationController
  def show
    @university = current_user.university
    @faculty = current_user.faculty
  end

  def edit
    authorize! :edit, current_user
    @university = current_user.university
    if @university.nil?
      redirect_to user_university_edit_path, :alert => t('error.university.notselected')
    end
    @current_faculty = current_user.faculty
  end

  def update
    authorize! :edit, current_user
    faculty = Faculty.find(params[:faculty_id])
    if faculty.nil?
      redirect_to user_faculty_new_path, :alert => t('error.faculty.nil')
    end
    current_user.faculty = faculty
    #Update the faculty requirement programs by removing the old ones and adding the new ones
    current_user.course_scenarios.each do |scenario|
      scenario.programs.where(:type_id => ProgramsType.find_by_name('faculty')).destroy_all
      scenario.programs << faculty.faculty_requirements unless faculty.faculty_requirements.nil?
    end
    current_user.save
    redirect_to user_education_path
  end

  def delete
    current_user.faculty = nil
    current_user.save
  end
end
