module User::CourseHelper

  def user_course_buttons(course, useajax = false, delete_parent: '')
    if user_signed_in?
      if current_user.has_completed_course?(course)
        user_course_completed = current_user.completed_courses.where(:course_id => course.id).first
        render 'user/course/course_completed_buttons', course: user_course_completed, useajax: useajax, delete_parent: delete_parent
      elsif current_scenario.plan_to_take_course?(course)
        user_course_taking = current_scenario.taking_courses.where(:course_id => course.id).first
        render 'user/course/course_taking_buttons', course: user_course_taking, useajax: useajax, delete_parent: delete_parent
      else
        render 'user/course/course_default_buttons', course: course, useajax: useajax, delete_parent: delete_parent
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
    html[:class] = 'form-inline'
    html[:class] += ' useajax' if params[:useajax]
    html['data-delete-parent'] = params[:delete_parent] unless params[:delete_parent].nil?
    html['data-reload']= params[:reload] unless params[:reload].nil?
    render :partial => 'user/course/complete_inline_form', :locals =>
        {:course => user_taking_course.course, :course_complete => course_complete, :grades => grades, :html => html}
  end
end
