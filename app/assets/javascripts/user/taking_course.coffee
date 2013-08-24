$(document).ready ()->
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

    })


