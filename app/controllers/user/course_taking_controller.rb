class User::CourseTakingController < ApplicationController
  before_action :setup, :except => :sort_course

  def setup
    authorize! :edit, current_user
    params[:id] = params[:course_id] unless params[:course_id].nil?
    @course = Course::Course.find(params[:id]) unless params[:id].nil?
    if @course.nil?
      if request.xhr?
        return_json('course.notfound', :success => false)
      else
        flash[:notice] = 'Course not found'
        _redirect_to :back
      end
    end
    @semesters = Course::Semester.all


  end

  #Sort the course
  def sort_course
    @years = {}
    term = current_term.first_of_year
    @previous_courses = current_scenario.get_course_before_than(term.semester, term.year)
    (0..4).each do |year|
      terms = {}
      (1..3).each do
        courses = current_scenario.get_course_in_semester(term.semester, term.year)
        terms[term] = courses
        term = term.next
      end
      @years[year] = terms
    end
    current_scenario.taking_courses.each do |course|
    end
  end

  def update_course_taking
    course = Course::Course.find(params[:course_id])
    user_taking_course = current_scenario.taking_courses.where(:course_id => course.id).first

    #if the action is to remove the course
    if params[:remove] == 'true'
      user_taking_course.destroy unless user_taking_course.nil?
    else
      if user_taking_course.nil? #if user is not currently taking the course mark this course as taking
        user_taking_course = UserTakingCourse.new
        user_taking_course.course_scenario = current_scenario
        user_taking_course.course = course
      end

      #Update the time when the user is taking the course
      user_taking_course.semester = Course::Semester.find(params[:semester_id])
      user_taking_course.year = params[:year]
      user_taking_course.save
    end

    #Load the list of courses that are now taken at the wrong time
    invalid_courses = []
    current_scenario.taking_courses.each do |c|
      invalid_courses << c.course.id unless c.is_time_valid?
    end
    if params[:remove] == 'true'
      return_json('course.take.remove.success', :invalid_courses => invalid_courses)
    else
      if params[:need_reload]
        html = render_to_string :partial => 'course/course_list_item', :locals => {:course => user_taking_course, :invalid_time => false}
      else
        html = ''
      end
      return_json('course.take.update.success', :invalid_courses => invalid_courses, :html => html)
    end

  end

  #Display a list of course to be taken or completed
  def add_course
    @courses = Course::Course.all.sort_by! { |x| [x.subject.name, x.code] }.to_a
    current_user.completed_courses.each do |c|
      @courses.destroy(c.course)
    end
    current_user.main_course_scenario.taking_courses.each do |c|
      @courses.destroy(c)
    end
    @courses = @courses.map { |x| [x.subject.name + " " + x.code.to_s + " - " + x.name, x.id] }
  end

  #decide which type of course to take
  def handle_add_course
    @course = params[:course]
    if Course::Course.find(@course)
      if params[:take]
        _redirect_to user_take_course_path(@course)
      elsif params[:complete]
        _redirect_to user_complete_course_path(@course)
      else
        puts 'Wrong params'
      end
    end
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
        return_json('course.course_taking.added', :url => course_graph_embed_path(@course))
      else
        _redirect_to course_path(@course)
      end
    else
      _render 'new'
    end
  end

  def complete
    @user_completed_course = UserCompletedCourse.new
    @grades = current_user.university.grading_system.entities
    user_taking_course = current_scenario.taking_courses.where(:course_id => @course.id).first

    unless user_taking_course.nil? #Check if the course was already mark as taking
      @user_completed_course.semester = user_taking_course.semester
      @user_completed_course.year = user_taking_course.year
    end
    _render 'complete'
  end

  def create_complete
    @user_completed_course = UserCompletedCourse.new(params.require(:user_completed_course).permit(:semester_id, :year, :grade_id))
    user_taking_course = current_scenario.taking_courses.where(:course_id => @course.id).first
    unless user_taking_course.nil? #If the course was taken before
      user_taking_course.destroy
    end
    @user_completed_course.course = @course
    @user_completed_course.user = current_user

    if @user_completed_course.save
      if request.xhr?
        if params[:graph_embed]
          return_json('course.completed', :url => course_graph_embed_path(@course))
        else
          return_json('course.completed')
        end

      else
        _redirect_to course_path(@course)
      end
    else
      _render 'complete'
    end
  end

  def remove
    user_taking_course = current_scenario.taking_courses.where(:course_id => @course).first
    user_completed_course = current_user.completed_courses.where(:course_id => @course).first

    user_taking_course.destroy unless user_taking_course.nil?
    user_completed_course.destroy unless user_completed_course.nil?

    if request.xhr?
      return_json('course.untake', :url => course_graph_embed_path(@course))
    else
      _redirect_to :back
    end
  end

end