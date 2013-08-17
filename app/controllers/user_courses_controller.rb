class UserCoursesController < ApplicationController
  def index
    if current_user.nil?
      redirect_to :status => 404
    end
    if current_user.university.nil?
      redirect_to user_dashboard_index_path, :alert => t('university.unselected')
    end
  end

  def remove_course_taking
    course = params['data-service']
    UserTakingCourse.find(course).destroy
    return_success('remove.course.taking')
  end

  def complete_course_taking
    course = params['data-service']
    newcourse = UserCompletedCourse.new
    newcourse.course = UserTakingCourse.find(course).course
    newcourse.user = current_user
    UserTakingCourse.find(course).destroy
    newcourse.save
    return_success('complete.course.taking')
  end

  def remove_course_completed
    course = params['data-service']
    UserCompletedCourse.find(course).destroy
    return_success('remove.course.completed')
  end

  def add_course
    course = Course::Course.find(params['course'])
    if params[:completed]
      completedcourse = UserCompletedCourse.new
      completedcourse.course = course
      completedcourse.user = current_user
      completedcourse.save
      return_success('add.course.completed')
    else
      takingcourse = UserTakingCourse.new
      takingcourse.course = course
      takingcourse.user = current_user
      takingcourse.save
      return_success('add.course.inprogress')
    end
  end

  def return_success(message)
    if request.xhr? #if the request was with ajax return json
      json = {}
      json[:success] = true
      json[:message] = t(message)
      render :json => json.to_json
    else
      flash[:notice] = t(message)
      redirect_to user_courses_index_path
    end

  end

  def add
    @courses = Course::Course.all.to_a
    current_user.taking_courses.each do |tc|
      @courses.delete(tc.course)
    end
    current_user.completed_courses.each do |tc|
      @courses.delete(tc.course)
    end
    @courses.sort_by! { |c| c.to_s }
    @courses = @courses.map { |x| [x.to_s + " - " + x.name, x.id] }
  end

end
