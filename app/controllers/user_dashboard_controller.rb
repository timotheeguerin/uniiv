class UserDashboardController < ApplicationController
  def index
    authorize! :read, current_user

    @university = current_user.university
    @faculty = current_user.faculty
    @programs = current_user.main_course_scenario.programs
  end

  def user_course_taking_content
    render :partial => 'course_taking', :layout => false
  end

  def user_course_completed_content
    render :partial => 'course_completed', :layout => false
  end
end
