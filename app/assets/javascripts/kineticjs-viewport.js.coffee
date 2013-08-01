#=require kineticjs

class window.ViewPort

  constructor: (options) ->
    defaults = {
      container: 'canvas-container',
      width: 700,
      height: 400
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
    #TODO change to canvas offset
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

    @stage.add(@layer)


  resizeLayer: (width, height) ->
    @background.setWidth(width)
    @background.setHeight(height)
    @layerSize.x = width
    @layerSize.y = height


  zoom: (event) ->
    minScaleX = @canvasSize.x / @layerSize.x
    minScaleY = @canvasSize.y / @layerSize.y
    minScale = Math.max(minScaleX, minScaleY)

    event.preventDefault()
    oevt = event.originalEvent
    mx = oevt.pageX - @offset.left
    my = oevt.pageY - @offset.top

    zoomAmount = oevt.wheelDelta * 0.001
    oldScale = @layer.getScale().x
    newScale = oldScale + zoomAmount
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


  verifyPosition: (pos) ->
    newX = pos.x;
    newY = pos.y;

    currentScale = @layer.getScale().x;
    if (pos.x > 0)
      newX = 0
    if (pos.y > 0)
      newY = 0
    if (@canvasSize.x - pos.x > @layerSize.x * currentScale)
      newX = @canvasSize.x - @layerSize.x * currentScale
    if (@canvasSize.y - pos.y > @layerSize.y * currentScale)
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
