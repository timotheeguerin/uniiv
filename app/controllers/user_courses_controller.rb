class UserCoursesController < ApplicationController
  def index
    if current_user.nil?
      redirect_to :status => 404
    end
    if current_user.university.nil?
      redirect_to user_dashboard_index_path, :alert => t("university.unselected")
    end
  end
  
  def removeCourseTaking
    course = params["data-service"]
    UserTakingCourse.find(course).destroy
    flash[:notice] = t("remove.course.taking")
    redirect_to user_courses_index_path
  end
  
  def completeCourseTaking
    course = params["data-service"]
    newcourse = UserCompletedCourse.new
    newcourse.course = UserTakingCourse.find(course).course
    newcourse.user = current_user
    UserTakingCourse.find(course).destroy
    newcourse.save
    flash[:notice] = t("complete.course.taking")
    redirect_to user_courses_index_path
  end
  
    def removeCourseCompleted
    course = params["data-service"]
    UserCompletedCourse.find(course).destroy
    flash[:notice] = t("remove.course.completed")
    redirect_to user_courses_index_path
  end
  
  def addCourse
  course = Course::Course.find(params["course"])
    if params[:completed]
    completedcourse = UserCompletedCourse.new
    completedcourse.course = course
    completedcourse.user = current_user
    completedcourse.save
    flash[:notice] = t("add.course.completed")
    redirect_to user_courses_index_path
  else
    takingcourse = UserTakingCourse.new
    takingcourse.course = course
    takingcourse.user = current_user
    takingcourse.save
    flash[:notice] = t("add.course.inprogress")
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
    @courses.sort_by!{|c| c.to_s}
    @courses = @courses.map{|x| [x.to_s + " - " + x.name, x.id]}
  end
  
end
