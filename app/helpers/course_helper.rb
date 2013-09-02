module CourseHelper

  def get_course_css_class(course)
    state = course.get_course_state(current_scenario)
    case state
      when 'completed'
        'course_completed'
      when 'course_taking'
        return 'course_taking'
      when 'available'
        return 'course_available'
      when 'unavailable'
        return 'course_unavailable'
      else
        return 'course_unavailable'
    end
  end

  def get_expr_html(expr)
    get_node_html(expr.node)
  end

  def get_node_html(node)
    r = ''
    return '' if node.operation.nil?
    if node.operation == NodeOperation::NODE
      course = node.course
      r = r + "<a href='#{course_path(:id => course.id)}' data-id='#{course.id}' data-type='course' class='#{get_course_css_class(course)} underline_link'>#{course.to_s}</a>"
    else
      r = r + ' (' + node.nodes.map! { |k| "#{get_node_html(k)}" }.join(' ' + node.operation + ' ') + ') '
    end
    r
  end

  def user_remove_course_form(course)

  end

end
