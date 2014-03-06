module User::CourseTakingHelper

  def user_course_buttons(course, useajax = false)
    if user_signed_in?
      if current_user.has_completed_course?(course)
        user_course_completed = current_user.completed_courses.where { course_id = course.id }.first
        render :partial => 'user/course_taking/course_taking_buttons', :locals => {:course => user_course_completed, :useajax=> useajax}
      elsif current_scenario.is_taking_course?(course)
        user_course_taking = current_scenario.taking_courses.where { course_id = course.id }.first
        render :partial => 'user/course_taking/course_taking_buttons', :locals => {:course => user_course_taking, :useajax=> useajax}
      end
    else

    end
  end

  def complete_course_inline_form(user_taking_course, params= {})
    course_complete = UserCompletedCourse.new
    grades = current_user.university.grading_system.entities

    course_complete.semester = user_taking_course.semester
    course_complete.year = user_taking_course.year
    html = {}
    html[:class] = 'useajax' if params[:useajax]
    html['data-delete-parent'] = params[:delete_parent] unless params[:delete_parent].nil?
    html['data-reload']= params[:reload] unless params[:reload].nil?
    render :partial => 'user/course_taking/complete_inline_form', :locals =>
        {:course => user_taking_course.course, :course_complete => course_complete, :grades => grades, :html => html}
  end
end
