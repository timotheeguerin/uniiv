class UserCourse::TakingController < ApplicationController
  before_action :setup

  def setup
    @course = Course::Course.find(params[:id])
    @semesters = Course::Semester.all
  end

  def new
    @user_taking_course = UserTakingCourse.new
  end

  def new_graph_embed
    @user_taking_course = UserTakingCourse.new
    render :layout => false
  end

  def create
    if create_take
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def create_graph_embed
    if create_take
      redirect_to course_graph_embed_path(@course)
    else
      render 'new_graph_embed'
    end
  end

  def create_take
    @user_taking_course = UserTakingCourse.new(params[:user_taking_course].permit(:semester_id, :year))
    @user_taking_course.course = @course
    @user_taking_course.user = current_user
    @user_taking_course.save
  end

end