class UserCoursesController < ApplicationController
  def index
    if current_user.nil?
      redirect_to :status => 404
    end
  end
  
  def removeCourseTaking
    course = params["data-service"]
    UserTakingCourse.find(course).destroy
    
    redirect_to user_courses_index_path
  end
  
    def removeCourseCompleted
    course = params["data-service"]
    UserCompletedCourse.find(course).destroy
    
    redirect_to user_courses_index_path
  end
  
  
end
