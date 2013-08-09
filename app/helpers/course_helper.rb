module CourseHelper

  def get_course_css_class(user, course)
    state = course.get_course_state(user)
    if state == "completed"
      return "course_completed"
    elsif state == "taking"
      return "course_taking"
    elsif state == "available"
      return "course_available"
    elsif state == "unavailable"
      return "course_unavailable"
    end
  end

end
