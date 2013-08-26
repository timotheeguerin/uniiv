$(document).ready ()->
  $('#moveableboxsortcourse').each ()->
    top = $(this).attr('data-topspacing')

    $(this).sticky({topSpacing: parseInt(top)})

  $(document).on('searchAjaxComplete', '#search_new_course', () ->
    $('#search-output-container').sortable({
      group: 'course-sort'
    })
  )
  $('#course_sorter').each ()->
    course_sorter = $(this)
    message_container = $(this).children('#message_container')
    update_url = $(this).attr('data-update-url')
    $('.sortable').each ()->
      adjustment = {}
      element = $(this)
      drop = true
      if element.hasClass('no-drop')
        drop = false
      element.sortable({
        group: 'course-sort'
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
          type = ul.attr('data-type')
          course_id = $item.children().attr('data-course-id')
          semester = ul.attr('data-semester')
          year = ul.attr('data-year')
          remove = false
          remove = true if type == 'delete'

          if remove
            $item.remove()
          $.post(update_url, {
            course_id: course_id
            semester_id: semester
            year: year
            remove: remove
          }).success((data) ->
            message_container.text(data.message)
            setTimeout(() ->
              message_container.text('')
            , 3000)
          ).error (error) ->
            console.log(error)
      })


