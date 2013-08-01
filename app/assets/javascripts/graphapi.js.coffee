#=require kineticjs-viewport

$(document).ready ->
  con = $('#canvas-container')
  console.log("H: " + con.parent().height())
  graph = new CanGraph({
    container: 'canvas-container'
  })

  graph.load "/graph/1/data", () ->
    #graph.drawCourse("Comp 202", new Point(30, 30))
    #graph.drawCourse("Comp 250", new Point(120, 30))
    #graph.drawArrow(120, 100, 200, 200)
    #add the shape to the layer
  graph.update()


class Ressources
  @images: {}
  @style: {}

  @loadImageFromJson: (data) ->
    for k0, v0 of data.style #for all the class in the style
      for k, v of v0
        if(v.background? && v.background.image? && v.background.image.src?)
          @addImage(v.background.image.src);

  @addImage: (src) ->
    if(!@images[src]?)
      image = new Image()
      image.src = src
      @images[src] = image

  #Call the given function when all images are loaded
  @onLoadImage: (callback) ->
    loadedImages = 0
    numImages = 0
    #get num of sources
    for src, image of @images
      numImages += 1

    for src, image of @images
      image.onload = ()   ->
        if (++loadedImages >= numImages)
          callback()


class CanGraph
  constructor: (options) ->
    defaults = {
      container: 'canvas',
    }
    @options = $.extend({}, defaults, options)
    html_container = $('#' + @options.container)
    @viewport = new ViewPort({
      container: options.container,
      width: html_container.width()
      height: html_container.height()
    })

    @ressources = {}
    @graphs = []

    @container = new Kinetic.Group(
      x: 0
      y: 0
    )
    @viewport.layer.add(@container)

  load: (url, callback) ->
    $.get(url, (data) =>
      Ressources.loadImageFromJson (data)
      Ressources.style = data.style
      Ressources.onLoadImage => #Wait for the images to load
        @loadGraphs(data)
        callback()

    , "json")

  loadGraphs: (data)->
    if(!data.graphs?)
      return
    margin = 30 #TODO load from style
    maxHeight = 0
    maxWidth = 0
    totalWidth = margin;

    for graph in data.graphs
      maxWidth = graph.dimension.x if graph.dimension.x > maxWidth
      maxHeight = graph.dimension.y if  graph.dimension.y > maxHeight
      totalWidth += graph.dimension.x + margin

      group = new Kinetic.Group(
        x: 0
        y: 0
        width: graph.dimension.x
        height: graph.dimension.y
      )
      g = new Graph(group, @, graph)
      @graphs.push(g)
      @container.add(group)


    maxWidth = @viewport.canvasSize.x if maxWidth < @viewport.canvasSize.x
    maxHeight = @viewport.canvasSize.y if maxHeight < @viewport.canvasSize.y
    @container.setSize(maxWidth, maxHeight)
    @viewport.resizeLayer(@container.getWidth(), @container.getHeight())

    graphX = (@container.getWidth() - totalWidth) / 2 + margin
    for graph in @graphs

      x = graphX
      y = (@container.getHeight() - graph.getHeight()) / 2
      graph.setPosition(x, y)
      graphX += graph.getWidth() + margin

    @update();

  update: ->
    @viewport.update()

State =
  DEFAULT: 0
  HOVER: 1
  ACTIVE: 2

class GraphElement
  constructor: (@group, @label, @style, @graph) ->
    @ishover = false
    @ustate = State.DEFAULT

    @on 'mouseenter', () =>
      @ishover = true
      @ustate = State.HOVER
    @on 'mouseleave', () =>
      @ishover = false
      @ustate = State.DEFAULT
    @on 'mousedown', () =>
      @ustate = State.ACTIVE
    @on 'mousedown', () =>
      if @ishover
        @ustate = State.HOVER
      else
        @ustate = State.DEFAULT

  on: (event, callback) ->
    @group.on(event, () =>
      callback()
      @update()
    )

  update: ->
    switch @ustate
      when State.DEFAULT
        @applyStyle(@style.normal)
      when State.HOVER
        @applyStyle(@style.normal, @style.hover)
      when State.ACTIVE
        @applyStyle(@style.normal, @style.active)
      else
        @applyStyle(@style.normal)
    @graph.update()

  applyStyle: (defaultStyle, stateStyle) ->
    style = $.extend(true, {}, defaultStyle, stateStyle)
    label = @group.get(".label")[0]
    if(!label?)
      label = new Kinetic.Text({
        x: 0,
        y: 0,
        text: @label,
        fontSize: 20,
        fontFamily: 'Calibri',
        fill: 'black'
        name: 'label'
        width: @group.getWidth()
        height: @group.getHeight()
        align: 'center'
        padding: 5
      });

      @group.add(label)


    if(style.background?) #if the background property is defined
      background = @group.get(".background")[0]
      if(!background?)
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
      if(style.background.cornerradius?)#if the border radius is defined
        background.setCornerRadius(style.background.cornerradius)
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
    label.setZIndex(20) if label?

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

class Graph
  constructor: (@group, @can_graph, data) ->
    @load(data)

  load: (data) ->
    for node in data.nodes                         #Load all nodes
      x = node.position.x - node.dimension.x / 2
      y = node.position.y - node.dimension.y / 2
      @addNode(node.label, x, y, node.dimension.x, node.dimension.y, node.type, node['class'])
    for edge in data.edges
      @addEdge(edge)

  addNode: (text, x, y, width, height, type, clazz) ->
    typeStyle = Ressources.style[type.toLowerCase()]
    customStyle = Ressources.style[clazz]
    computedStyle = $.extend({}, typeStyle, customStyle)

    group = new Kinetic.Group({
      x: x
      y: y
      width: width
      height: height
    })

    @group.add(group)
    node = new GraphElement(group, text, computedStyle, @can_graph)
    node.update()

  addEdge: (edge)   ->
    points = edge.positions
    spline = new Kinetic.Spline({
      points: points,
      stroke: 'blue',
      strokeWidth: 1,
      lineCap: 'round',
      tension: 1
    })
    @group.add(spline)
    if(edge.arrow == 0)
      a = points[0]
      b = points[1]
      poly = @getTriangle(a, b)
      @group.add(poly)

  getTriangle: (a, b)    ->
    angle = @angle(b, a)
    delta = 30 * Math.PI / 180
    l = 14
    c = {
      x: parseFloat(a.x) + l * Math.cos(angle + delta / 2)
      y: parseFloat(a.y) + l * Math.sin(angle + delta / 2)
    }
    d = {
      x: parseFloat(a.x) + l * Math.cos(angle - delta / 2)
      y: parseFloat(a.y) + l * Math.sin(angle - delta / 2)
    }
    poly = new Kinetic.Shape({
      drawFunc: (canvas) ->
        context = canvas.getContext();
        context.beginPath();
        context.moveTo(a.x, a.y);
        context.lineTo(c.x, c.y);
        #context.quadraticCurveTo(a.x, a.y, d.x, d.y);
        context.lineTo(d.x, d.y)
        context.closePath();
        canvas.fillStroke(this);
      fill: 'blue'
    });
    return poly


  angle: (a, b) ->
    v = {
      x: a.x - b.x
      y: a.y - b.y
    }
    return Math.acos((v.x) / Math.sqrt(Math.pow(v.x, 2) + Math.pow(v.y, 2)))

  getWidth: () ->
    return @group.getWidth()

  getHeight: () ->
    return @group.getHeight()

  setPosition: (x, y) ->
    return @group.setPosition(x, y)