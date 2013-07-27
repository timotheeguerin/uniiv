#=require kineticjs-viewport

$(document).ready ->
  graph = new Graph({
    container: 'canvas-container'
  })

  graph.load "/assets/test.json", () ->

  rect = new Kinetic.Rect({
    x: 10,
    y: 10,
    width: 980,
    height: 980,
    fill: '#DBDBDB',
    stroke: 'blue',
    strokeWidth: 4
  })

  graph.viewport.layer.add(rect)

  graph.onLoadImage ->
    graph.drawCourse("Comp 202", new Point(30, 30))
    graph.drawCourse("Comp 250", new Point(120, 30))
    graph.drawArrow(120, 100, 200, 200)


  #add the shape to the layer
  graph.update()


class Graph
  constructor: (options) ->
    defaults = {
      container: 'canvas',
      width: 700,
      height: 400
    }
    @options = $.extend({}, defaults, options)
    @viewport = new ViewPort({
      container: options.container,
      width: options.width,
      height: options.height
    })

    @images = {}
  #initImage('/assets')

  load: (url, callback) ->
    $.post(url, (data) =>
      @viewport.resizeLayer(data.graph.dimension.width, data.graph.dimension.height)
    , "json")
    callback()

  initImage: (url) ->
    @ressources.url = url
    @addImage("course.unavailable")

  onLoadImage: (callback) ->
    loadedImages = 0
    numImages = @images.length
    #get num of sources


    for src in @images
      if (@images.hasOwnProperty(src))
        @images[src].onload = ()   ->
          if (++loadedImages >= numImages)
            callback()

  drawCourse: (course, pos) ->
    group = new Kinetic.Group({
      x: pos.x,
      y: pos.y,
      draggable: true
    })

    rect = new Kinetic.Rect({
      x: 0,
      y: 0,
      width: 70,
      height: 70,
      cornerRadius: 10,
      fill: '#DBDBDB',
      stroke: 'blue',
      strokeWidth: 4
    })

    image = new Kinetic.Image({
      x: 5,
      y: 5,
      image: @images['course.unavailable'],
      width: 20,
      height: 20

    })

    text = new Kinetic.Text({
      x: 5,
      y: 30,
      text: course,
      fontSize: 12,
      fontFamily: 'Helvetica',
      fill: 'black'
    })

    group.add(rect)
    group.add(image)
    group.add(text)
    # add the shape to the layer
    @viewport.layer.add(group)
    update()

  drawArrow: (fromx, fromy, tox, toy) ->
    headlen = 20 # how long you want the head of the arrow to be, you could calculate this as a fraction of the distance between the points as well.
    angle = Math.atan2(toy - fromy, tox - fromx)

    line = new Kinetic.Line({
      points: [fromx, fromy, tox, toy, tox - headlen * Math.cos(angle - Math.PI / 6),
               toy - headlen * Math.sin(angle - Math.PI / 6), tox, toy,
               tox - headlen * Math.cos(angle + Math.PI / 6), toy - headlen * Math.sin(angle + Math.PI / 6)],
      stroke: "red"
    })
    @viewport.layer.add(line)

  addImage: (key) ->
    src = key.replace(/\./g, '/')
    image = new Image()
    image.src = @ressources.url + '/' + src + '.png'
    @images[key] = image

  update: ->
    @viewport.update()
