module CourseHelper

  def get_course_css_class(course)
    state = course.get_course_state(current_scenario)
    case state
      when CourseState::COMPLETED
        'course_completed'
      when CourseState::TAKING
        return 'course_taking'
      when CourseState::AVAILABLE
        return 'course_available'
      when CourseState::UNAVAILABLE
        return 'course_unavailable'
      else
        return 'course_unavailable'
    end
  end

  def get_expr_html(expr, template = nil)
    get_node_html(expr.node, template)
  end

  def get_node_html(node, template = nil)
    r = ''
    return '' if node.operation.nil?
    if node.operation == NodeOperation::NODE
      course = node.course
      if template.nil?
        r = r + "<a href='#{course_path(:id => course.id)}' data-id='#{course.id}' data-type='course' class='#{get_course_css_class(course)} underline_link'>#{course.to_s}</a>"
      else
        r += render template, :course => course
      end
    else
      r = r + ' (' + node.nodes.map! { |k| "#{get_node_html(k, template)}" }.join(' ' + node.operation + ' ') + ') '
    end
    r
  end

  def user_remove_course_form(course)

  end

  def course_list_item(course)
    invalid_time = (not course.is_time_valid?)
    render 'course/course_list_item', :course => course, :invalid_time => invalid_time
  end

  def course_status_icon(course)
    state = course.get_course_state(current_scenario)
    content = ''
    case state
      when CourseState::COMPLETED
        content = content_tag 'span', '', :class => 'glyphicon glyphicon-ok-circle bluetext', :title => t('course.completed'), 'data-toggle'=> 'tooltip'
      when CourseState::TAKING
        content = content_tag 'span', '', :class => 'glyphicon glyphicon-time yellowtext', :title => t('course.taking'), 'data-toggle'=> 'tooltip'
      when CourseState::AVAILABLE
        content = content_tag 'span', '', :class => 'glyphicon glyphicon-thumbs-up greentext', :title => t('course.available'), 'data-toggle'=> 'tooltip'
      when CourseState::UNAVAILABLE
        content = content_tag 'span', '', :class => 'glyphicon glyphicon-ban-circle redtext', :title => t('course.unavailable'), 'data-toggle'=> 'tooltip'
    end
    content
  end

end
