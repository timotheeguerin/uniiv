#=require graph/element/GraphElement

class BoxElement extends GraphElement
  @label = ''

  constructor: (group, style, graph, @id) ->
    super group, style, graph

  computeStyle: (style) ->
    if(style.background?) #if the background property is defined
      background = @group.get(".background")[0]
      if(!background?)
        if(@style.shape == 'circle')
          background = new Kinetic.Circle({
            x: @group.getWidth() / 2
            y: @group.getHeight() / 2
            radius: @group.getWidth() / 2
            name: 'background'

          });
        else
          background = new Kinetic.Rect({
            x: 0
            y: 0
            width: @group.getWidth()
            height: @group.getHeight()
            name: 'background'

          });
        @group.add(background)

      if(style.background.border?)      #If a border is defined
        border = style.background.border;
        background.setStroke(border.color)
        background.setStrokeWidth(border.width)
      if(style.background.cornerradius? && @style.shape == 'rect')#if the border radius is defined
        background.setCornerRadius(style.background.cornerradius)
      if(style.background.color?)
        background.setFill(style.background.color)
      if(style.background.image?)       #if the background have an image
        image = style.background.image
        src = style.background.image.src
        background.setFillPatternImage(Ressources.images[src])

        if(image.offset?)
          background.setFillPatternOffset(image.offset.x, image.offset.y)
        else
          background.setFillPatternOffset(0, 0)

      if(style.background.gradient?)
        gradient = style.background.gradient
        angle = @computeAngle(gradient.angle)
        background.setAttrs({
          fillLinearGradientStartPoint: angle.start,
          fillLinearGradientEndPoint: angle.end,
          fillLinearGradientColorStops: gradient.colors
        });

    background.setZIndex(10) if background?

  computeAngle: (val) ->
    if(!val?)
      val = "top"
    switch val
      when "left"
        {
        start: [0, 0],
        end: [@style.width, 0]
        }
      when "right"
        {
        start: [@style.width, 0],
        end: [0, 0]
        }
      when "top"
        {
        start: [0, 0],
        end: [0, @style.height]
        }
      when "bottom"
        {
        start: [0, @style.height],
        end: [0, 0]
        }
      else
        tan = Math.tan(val * (Math.PI / 180))

        x = 1 / tan
        y = tan

        if(90 < val < 270)
          x = -x
        if(180 < val < 360)
          y = -y

        if(x > 1)
          x = 1
        if(x < -1)
          x = -1
        if(y > 1)
          y = 1
        if(y < -1)
          y = -1


        return {
        start: [(1 - x) * (@group.getWidth() / 2), (1 - y) * (@group.getHeight() / 2)],
        end: [(1 + x) * (@group.getWidth() / 2), (1 + y) * (@group.getHeight() / 2)]
        }

window.BoxElement = BoxElement