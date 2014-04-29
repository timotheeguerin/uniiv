class User::CourseController < ApplicationController
  before_action :setup

  def setup
    authorize! :edit, current_user
    @course = Course::Course.find(params[:course_id]) unless params[:course_id].nil?
    if @course.nil?
      if request.xhr?
        return_json('course.notfound', :success => false)
      else
        flash[:notice] = 'Course not found'
        _redirect_to :back
      end
    end
  end

  def complete_show
    @user_completed_course = UserCompletedCourse.new
    @grades = current_user.university.grading_system.entities
    user_taking_course = current_scenario.taking_courses.where(:course_id => @course.id).first

    unless user_taking_course.nil? #Check if the course was already mark as taking
      @user_completed_course.semester = user_taking_course.semester
      @user_completed_course.year = user_taking_course.year
    end
    _render 'complete'
  end

  def complete_create
    @user_completed_course = UserCompletedCourse.new(params.require(:user_completed_course).permit(:semester_id, :year, :grade_id))
    user_taking_course = current_scenario.taking_courses.where(:course_id => @course.id).first
    unless user_taking_course.nil? #If the course was taken before
      user_taking_course.destroy
    end
    @user_completed_course.course = @course
    @user_completed_course.user = current_user
    @grades = current_user.university.grading_system.entities
    if @user_completed_course.save
      redirect_or_json(:message => 'course.completed', :destination => course_path(@course))
    else
      render_or_json :view => 'complete', :success => false
    end
  end


  #Remove a course the user is taking or has completed
  def remove
    current_scenario.untake_course(@course)

    if request.xhr?
      return_json('course.untake', :url => course_graph_embed_path(@course))
    else
      _redirect_to :back
    end
  end
end