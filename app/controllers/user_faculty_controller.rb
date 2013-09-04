class UserFacultyController < ApplicationController
  def show
    @university = current_user.university
    @faculty = current_user.faculty
  end

  def new
    @university = current_user.university
  end

  def create
    faculty = Faculty.find(params[:id])
    current_user.faculty = faculty
    current_user.save
  end

  def edit
    @university = current_user.university
    if @university.nil?
      redirect_to user_university_edit_path, :alert => t('error.university.notselected')
    end
    @current_faculty = current_user.faculty
  end

  def update
    faculty = Faculty.find(params[:fac])
    if faculty.nil?
      redirect_to user_faculty_new_path, :alert => t('error.faculty.nil')
    end
    current_user.faculty = faculty
    current_user.course_scenarios.each do |scenario|
      scenario.programs.where(:type_id => ProgramsType.find_by_name('faculty')).destroy_all #Remove all the faculty requirements
      puts 'fqr: ' + faculty.faculty_requirements.to_s
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
