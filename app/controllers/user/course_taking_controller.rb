class User::CourseTakingController < ApplicationController
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
    @user_taking_course = UserTakingCourse.new(params[:user_taking_course].permit(:semester_id, :year))
    @user_taking_course.course = @course
    @user_taking_course.user = current_user

    if @user_taking_course.save
      if params[:graph_embed]
        return_json('course.course_taking.added', course_graph_embed_path(@course))
      else
        redirect_to course_path(@course)
      end
    else
      if params[:graph_embed]
        render 'new_graph_embed'
      else
        render 'new'
      end
    end
  end

  def complete
    current_user.taking_courses.where(:course => @course).first
    if @user_taking_course.nil? #Check if the course was already mark as taking
      _render 'complete'
    else
      _render 'complete_taking'
    end
  end

  def create_complete

  end

  def remove
    user_taking_course = current_user.taking_courses.where(:course => @course).first
    user_taking_course.destroy unless user_taking_course.nil?
    if params[:graph_embed]
      return_json('course.course_taking.removed', course_graph_embed_path(@course))
    else
      redirect_to course_path(@course)
    end

  end

  def return_json(message, url)
    json = {}
    json[:success] = true
    json[:message] = t(message)
    json[:url] = url
    render :json => json.to_json
  end

  def _render(view)
    if params[:graph_embed]
      render :view => view + '_graph_embed', :layout => false
    else
      render view
    end
  end
end