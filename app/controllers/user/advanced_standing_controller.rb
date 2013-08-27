class User::AdvancedStandingController < ApplicationController

  def index
    @courses = current_user.completed_courses.where(:advanced_standing => true)
    @given_credit = current_user.advanced_standing_credits
  end

  def set_credit
    params[:credit] ||= 0
    current_user.advanced_standing_credits = params[:credit]
    return_json('advancedstanding.setcredit')
  end

  def create
    course = Course::Course.find(params[:course_id])
    if current_user.has_completed_course?(course)
      return_json('advancedstanding.alreadytaken')
    else
      completed_course = UserCompletedCourse.new
      completed_course.course = course
      completed_course.user = current_user
      completed_course.advanced_standing = true
      completed_course.save
      return_json('advancedstanding.added')
    end
  end

  def remove
    course = Course::Course.find(params[:course_id])
    if current_user.has_completed_course?(course)
      completed_course = current_user.completed_courses.where { :course_id == course.id && :advanced_standing == true }
      completed_course.destroy unless completed_course.nil?
    else
      return_json('advancedstanding.noexist')
    end
  end
end
