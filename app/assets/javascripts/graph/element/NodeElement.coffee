#=require graph/element/LabelElement

class NodeElement extends LabelElement
  constructor: (group, style, graph, label, id) ->
    super group, style, graph, label
    @id = id

  toString: () ->
    return @id + ' : ' + @label

  computeStyle: (style) ->
    super(style)
    if style.corner_status?
      if not @corner_element?
        if(@style.shape == 'circle')
          radius = style.corner_status.radius
          angle = style.corner_status.angle
          delta = style.corner_status.delta
          x = @group.getWidth() / 2 + Math.round((@group.getWidth() / 2 + delta) * Math.cos(angle * 3.14 / 180))
          y = @group.getWidth() / 2 + Math.round((@group.getWidth() / 2 + delta) * Math.sin(angle * 3.14 / 180))
          @corner_element = new Kinetic.Circle({
            x: x
            y: y
            radius: radius
            name: 'corner_element'
            fill: 'black'
          });
        else
          width = style.corner_status.dimension.x
          height = style.corner_status.dimension.y
          @corner_element = new Kinetic.Rect({
            x: 0
            y: 0
            width: width
            height: height
            name: 'corner_element'

          });
        @group.add(@corner_element)

      if style.corner_status.color?
        @corner_element.setFill(style.corner_status.color)
      @corner_element.setZIndex(10)


window.NodeElement = NodeElement
