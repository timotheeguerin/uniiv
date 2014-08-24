class User::CoursePlannerController < ApplicationController
  before_action :setup, :except => :index

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
  def index
    authorize! :edit, current_user
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
  end

  def take_course
    authorize! :edit, current_user
    #if the action is to remove the course
    semester = Course::Semester.find(params[:semester_id])
    user_taking_course = current_scenario.take_course(@course, Utils::Term.new(semester, params[:year]))

    #Load the show of courses that are now taken at the wrong time
    invalid_courses = get_invalid_courses
    html = if params[:need_reload]
             render_to_string :partial => 'course/sort_course_list_item', locals: {
                 course: user_taking_course, invalid_time: false, details: true}
           else
             ''
           end
    return_json('course.take.update.success', :invalid_courses => invalid_courses, :html => html)
  end

  def untake_course
    authorize! :edit, current_user
    user_taking_course = current_scenario.taking_courses.where(:course_id => @course.id).first
    user_taking_course.destroy unless user_taking_course.nil?
    return_json('course.take.remove.success', :invalid_courses => get_invalid_courses)
  end

  def get_invalid_courses
    invalid_courses = []
    current_scenario.taking_courses.each do |c|
      invalid_courses << c.course.id unless c.is_time_valid?
    end
    invalid_courses
  end
end