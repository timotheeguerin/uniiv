$(document).ready ()->
  $('#moveableboxsortcourse').each ()->
    top = $(this).attr('data-topspacing')

    $(this).sticky({topSpacing: parseInt(top)})

  $(document).on('searchAjaxComplete', '#search_new_course', () ->
    $('#search-output-container').sortable({
      group: 'course-sort'
    })
  )

  $('.sortable').each ()->
    adjustment = {}
    element = $(this)
    drop = true
    group = element.attr('data-group')
    if element.hasClass('no-drop')
      drop = false
    element.sortable({
      group: group
      drop: drop
      onDragStart: ($item, container, _super) -> #Reposition the draggin element relative from where it was grabbed
        offset = $item.offset()
        pointer = container.rootGroup.pointer

        adjustment = {
          left: pointer.left - offset.left,
          top: pointer.top - offset.top
        }
        _super($item, container)

      onDrag: ($item, position) ->
        $item.css({
          left: position.left - adjustment.left,
          top: position.top - adjustment.top
        })
      onDrop: ($item, container, _super) ->
        _super($item, container)
        ul = $item.closest('ul')
        update_url = ul.attr('data-update-url')
        type = ul.attr('data-type')
        course_id = $item.children().attr('data-course-id')
        params = ul.attr('data-params')
        remove = false
        remove = true if type == 'delete'

        parameters = $.extend(getURLParameters(params), {
          course_id: course_id
          remove: remove
        }
        )
        if remove
          $item.remove()
        $.post(update_url, parameters).success((data) ->
          ajaxPopupPush(data.message)
          unless remove
            $item.removeClass('invalid-time')
            $item.addClass(data.clazz)
        ).error (error) ->
          console.log(error)
    })

getURLParameters = (params) ->
  return {} unless params?
  result = {}
  sURLVariables = params.split('&')
  for variable in sURLVariables
    sParameterName = variable.split('=')
    result[sParameterName[0]] = sParameterName[1]
  return result