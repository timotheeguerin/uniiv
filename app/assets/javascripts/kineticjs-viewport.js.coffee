#=require kineticjs

class window.ViewPort

  constructor: (options) ->
    defaults = {
      container: 'canvas-container',
      width: 700,
      height: 400,
      zoomin_button: ''
      zoomout_button: ''
    }

    @options = $.extend({}, defaults, options)
    @canvasSize = new Point(@options.width, @options.height)

    @stage = new Kinetic.Stage({
      container: options.container,
      width: @canvasSize.x,
      height: @canvasSize.y
    })

    @layerSize = new Point(@canvasSize.x, @canvasSize.y)

    #Create the mainlayer
    @layer = new Kinetic.Layer({
      draggable: true,
      dragBoundFunc: (pos) =>
        @verifyPosition(pos)
    })
    @offset = $("#" + options.container).offset()

    #Enable all the layer to be draggable
    @background = new Kinetic.Rect({
      x: 0,
      y: 0,
      width: @layerSize.x,
      height: @layerSize.y,
      fill: "#000000",
      opacity: 0
    });
    @layer.add(@background)

    #Add the zoom event
    $(@stage.content).on('mousewheel', (event) =>
      @zoom(event));
    $(document).on 'click', @options.zoomin_button, ()->
      @zoom_delta(0.1)
    $(document).on 'click', @options.zoomout_button, ()->
      @zoom_delta(0.1)
    @stage.add(@layer)


  resizeLayer: (width, height) ->
    w = height
    h = height
    @background.setWidth(width)
    @background.setHeight(height)
    @layerSize.x = width
    @layerSize.y = height

  autoResizeBackground: () ->
    min_scale = @get_min_scale()
    w = @layer.getWidth() * min_scale
    h = @layer.getWidth() * min_scale
    w = @canvasSize.x if @canvasSize.x > w
    h = @canvasSize.y if @canvasSize.y > h
    @resizeLayer(w / min_scale, h / min_scale)

  zoom_to: (scale, mx = undefined, my = undefined) ->
    mx = @canvasSize.x / 2 unless mx?
    my = @canvasSize.y / 2 unless my?

    minScale = @get_min_scale()
    oldScale = @layer.getScale().x
    newScale = scale
    if (newScale < minScale)
      newScale = minScale
    else if (newScale > 2)
      newScale = 2
    dscale = newScale / oldScale;
    ox = mx - dscale * ( mx - @layer.getPosition().x)
    oy = my - dscale * (my - @layer.getPosition().y)
    @layer.setScale(newScale)
    pos = @verifyPosition(new Point(ox, oy))
    @layer.setPosition(pos.x, pos.y)

    @layer.draw();

  zoom_to_min: () ->
    scale = @get_min_scale()
    @zoom_to(scale)

  zoom_delta: (zoomAmount) ->
    oldScale = @layer.getScale().x
    newScale = oldScale + zoomAmount
    @zoom_to(newScale)

  zoom: (event) ->
    event.preventDefault()
    oevt = event.originalEvent
    mx = oevt.pageX - @offset.left
    my = oevt.pageY - @offset.top

    zoomAmount = oevt.wheelDelta * 0.001
    oldScale = @layer.getScale().x
    newScale = oldScale + zoomAmount
    @zoom_to(newScale, mx, my)


  get_min_scale: ()->
    minScaleX = @canvasSize.x / @layerSize.x
    minScaleY = @canvasSize.y / @layerSize.y
    minScale = Math.min(minScaleX, minScaleY)
    return minScale

  verifyPosition: (pos) ->
    newX = pos.x;
    newY = pos.y;

    currentScale = @layer.getScale().x;
    if (pos.x >= 0)
      newX = 0
    if (pos.y >= 0)
      newY = 0
    if (@canvasSize.x - pos.x >= @layerSize.x * currentScale)
      newX = @canvasSize.x - @layerSize.x * currentScale
    if (@canvasSize.y - pos.y >= @layerSize.y * currentScale)
      newY = @canvasSize.y - @layerSize.y * currentScale
    return {
    x: newX,
    y: newY
    }

  update: ->
    @layer.draw();

  resize: (x, y) ->
    @stage.setSize(x, y)

class Point
  constructor: (@x, @y) ->
  toString: ->
    return "(" + @x + ", " + @y + ")";
