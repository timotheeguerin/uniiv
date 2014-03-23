class User::AdvancedStandingController < ApplicationController

  def index
    @courses = current_user.completed_courses.where(:advanced_standing => true)
    @given_credit = current_user.advanced_standing_credits
  end

  def set_credit
    params[:credit] ||= 0
    current_user.advanced_standing_credits = params[:advanced_standing_credit]
    current_user.save
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
      if completed_course.save
        return_json('advancedstanding.added')
      else
        puts completed_course.errors.full_messages
        return_json(completed_course.errors.full_messages, :success => false)
      end
    end
  end

  def remove
    completed_course = current_user.completed_courses.where(:course_id => params[:course_id]).first
    if completed_course.nil?
      return_json('advancedstanding.noexist')
    else
      if completed_course.destroy
        return_json('advancedstanding.removed')
      else
        return_json(completed_course.errors.full_messages, :success => true)
      end
    end
  end
end
