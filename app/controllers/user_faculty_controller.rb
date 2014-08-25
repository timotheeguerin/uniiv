class UserFacultyController < ApplicationController
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
    current_user.faculty = faculty
    current_user.reset
    #Update the faculty requirement program by removing the old ones and adding the new ones
    current_user.course_scenarios.each do |scenario|
      scenario.programs.joins(:program).where(:program_programs => {:type_id => ProgramsType.find_by_name('faculty')}).destroy_all
      scenario.programs << faculty.faculty_requirements.versions.last unless faculty.faculty_requirements.nil?
    end
    current_user.save
    redirect_to user_education_selection_path
  end

  def delete
    authorize! :edit, current_user
    current_user.faculty = nil
    current_user.save
  end
end
