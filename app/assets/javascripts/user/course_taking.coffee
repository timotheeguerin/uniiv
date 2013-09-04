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
    handleSortable($(this))

getURLParameters = (params) ->
  return {} unless params?
  result = {}
  sURLVariables = params.split('&')
  for variable in sURLVariables
    sParameterName = variable.split('=')
    result[sParameterName[0]] = sParameterName[1]
  return result

checkDependencies = (course_id, remove = false) ->
  $('li.dependency').each () ->
    if $(this).children().attr('data-course-id') == course_id
      if remove
        $(this).removeClass('notsortable')
      else
        $(this).addClass('notsortable')


handleSortable = (element) ->
  adjustment = {}
  drop = true
  group = element.attr('data-group')
  if element.hasClass('no-drop')
    drop = false
  element.sortable({
    group: group
    drop: drop
    itemSelector: 'li:not(.notsortable)'
    onDragStart: ($item, container, _super) -> #Reposition the draggin element relative from where it was grabbed
      $item.data('origin-container', container.el[0])
      ul = $item.closest('ul')
      if ul.hasClass('duplicate')
        $item.clone().insertAfter($item)
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
      if $item.data('origin-container') == container.el[0] #Dont do anything if drop on the same box
        return
      ul = $item.closest('ul')
      update_url = ul.attr('data-update-url')
      type = ul.attr('data-type')
      course_id = $item.children().attr('data-course-id')
      params = ul.attr('data-params')
      remove = false
      need_reload = false
      remove = true if type == 'delete'
      need_reload = true if $item.children().attr('data-need-reload')

      parameters = $.extend(getURLParameters(params), {
        course_id: course_id
        remove: remove
        need_reload: need_reload
      })
      if remove
        $item.remove()
      loading_anim = $($("#loading_animation").html()).appendTo($item)
      loading_anim.show()
      $.post(update_url, parameters).success((data) ->
        ajaxPopupPush(data.message)
        if need_reload
          tmpItemp = $item.after(data.html)
          $item.remove()
          $item = tmpItemp

        #Remap event
        $item.find('ul.sortable').each () ->
          handleSortable($(this))

        if data.invalid_courses?
          $('div[data-course-id]').each ->
            if data.invalid_courses.indexOf(parseInt($(this).attr('data-course-id'))) == -1
              $(this).parent().removeClass('invalid-time')
            else
              $(this).parent().addClass('invalid-time')

        checkDependencies(course_id, remove)
        loading_anim.remove()

      ).error (error) ->
        console.log(error)
  })

