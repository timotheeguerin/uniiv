class User::CourseTakingController < ApplicationController
  before_action :setup

  def setup
    authorize! :edit, current_user
    @course = Course::Course.find(params[:id]) unless params[:id].nil?
    @semesters = Course::Semester.all
  end

  #Sort the course
  def sort_course
    @terms = {}
    term = current_term
    @previous_courses = current_scenario.get_course_before_than(term.semester, term.year)
    (1..12).each do
      courses = current_scenario.get_course_in_semester(term.semester, term.year)
      @terms[term] = courses
      term = term.next
    end
    current_scenario.taking_courses.each do |course|
    end
  end

  def update_course_taking
    course = Course::Course.find(params[:course_id])
    user_taking_course = current_scenario.taking_courses.where(:course_id => course.id).first
    if user_taking_course.nil?
      user_taking_course = UserTakingCourse.new
      user_taking_course.course_scenario = current_scenario
      user_taking_course.course = course
    end

    user_taking_course.semester = Course::Semester.find(params[:semester_id])
    user_taking_course.year = params[:year]
    user_taking_course.save
    return_json('course.take.update.success')

  end

  #Display a list of course to be taken or completed
  def add_course

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
    @user_taking_course.course_scenario = current_scenario

    if @user_taking_course.save
      if params[:graph_embed]
        return_json('course.course_taking.added', course_graph_embed_path(@course))
      else
        redirect_to course_path(@course)
      end
    else
      _render 'new'
    end
  end

  def complete
    @user_completed_course = UserCompletedCourse.new
    @grades = current_user.university.grading_system.entities
    user_taking_course = current_scenario.taking_courses.where(:course => @course).first

    unless user_taking_course.nil? #Check if the course was already mark as taking
      @user_completed_course.semester = user_taking_course.semester
      @user_completed_course.year = user_taking_course.year
    end
    _render 'complete'
  end

  def create_complete
    @user_completed_course = UserCompletedCourse.new(params[:user_completed_course].permit(:semester_id, :year, :grade_id))
    user_taking_course = current_scenario.taking_courses.where(:course => @course).first
    unless user_taking_course.nil? #If the course was taken before
      user_taking_course.destroy
    end
    @user_completed_course.course = @course
    @user_completed_course.user = current_user

    if @user_completed_course.save
      puts 'saved'
      if params[:graph_embed]
        return_json('course.completed', course_graph_embed_path(@course))
      else
        redirect_to course_path(@course)
      end
    else
      puts 'fail to save'
      _render 'new'
    end
  end

  def remove
    user_taking_course = current_scenario.taking_courses.where(:course => @course).first
    user_completed_course = current_user.completed_courses.where(:course => @course).first

    user_taking_course.destroy unless user_taking_course.nil?
    user_completed_course.destroy unless user_completed_course.nil?

    if params[:graph_embed]
      return_json('course.untake', course_graph_embed_path(@course))
    else
      redirect_to course_path(@course)
    end

  end

  def return_json(message, url = nil)
    json = {}
    json[:success] = true
    json[:message] = t(message)
    json[:url] = url unless url.nil?
    render :json => json.to_json
  end

  def _render(view)
    if params[:graph_embed]
      view += '_graph_embed'
      render view, :layout => false
    else
      render view
    end
  end
end