#=require graph/element/GraphElement
class ContainerElement extends GraphElement
  computeStyle: (style) ->
    background = @group.get('.background')[0]
    if not background?
      background = new Kinetic.Rect({
        x: 0
        y: 0
        width: @group.getWidth()
        height: @group.getHeight()
      })
      @group.add(background)
    if(style.border?)      #If a border is defined
      border = style.border;
      background.setStroke(border.color)
      background.setStrokeWidth(border.width)


window.ContainerElement = ContainerElement