module User::CourseTakingHelper

  def complete_course_inline_form(user_taking_course, params= {})
    course_complete = UserCompletedCourse.new
    grades = current_user.university.grading_system.entities

    course_complete.semester = user_taking_course.semester
    course_complete.year = user_taking_course.year
    html = {:class => 'useajax'}
    html['data-delete-parent'] = params[:delete_parent] unless params[:delete_parent].nil?
    render :partial => 'user/course_taking/complete_inline_form', :locals =>
        {:course => user_taking_course.course, :course_complete => course_complete, :grades => grades, :html=> html}
  end
end
