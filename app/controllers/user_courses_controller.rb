class UserCoursesController < ApplicationController
  def index
    if current_user.nil?
      redirect_to :status => 404
    end
  end
  
  def removeCourseTaking
    course = params["data-service"]
    UserTakingCourse.find(course).destroy
    flash[:notice] = t("remove.course.taking")
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
  
end
