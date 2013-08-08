#=require kineticjs-viewport
#=require graph/element/GraphElement
#=require graph/element/ContainerElement

resizeCanvasContainer = () ->
  newheight = $(window).height() - 40;
  $("#canvas-container").height(newheight)


$(document).ready ->
  resizeCanvasContainer()
  canvas_container = $('#canvas-container')
  if canvas_container?
    graph = new CanGraph({
      container: 'canvas-container'
      loading_container: 'graph_loader'
    })

    graph.load "/mygraph/data", () ->
      graph.update()
      graph.onNodeClick (node) ->
        name = node.name


    $(window).resize () ->
      resizeCanvasContainer()
      graph.resize()


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
      container: 'canvas'
      loading_container: 'canvas-loading'
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
    @nodes = []
    @edges = []
    @container = new Kinetic.Group(
      x: 0
      y: 0
    )
    @viewport.layer.add(@container)

    @canvas_container = $('#' + @options.container)
    @loading_screen = $('#' + @options.loading_container)

    @canvas_container.hide()
    @loading_screen.show() if @loading_screen?

  load: (url, callback) ->
    $.get(url, (data) =>
      Ressources.loadImageFromJson (data)
      Ressources.style = data.style
      Ressources.onLoadImage => #Wait for the images to load
        @loadGraphs(data)
        @canvas_container.show()
        @loading_screen.hide() if @loading_screen?
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
      nodes = @nodes.concat g.nodes #Add the list of nodes
      @edges = @edges.concat g.edges #Add the list of edges
      for node in nodes
        @nodes[node.id] ||= []
        @nodes[node.id].push(node)


      @container.add(group)

    @setupNodesListener()

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
    console.log('update')
    @viewport.update()

  resize: ()    ->
    html_container = $('#' + @options.container)
    x = html_container.width()
    y = html_container.height()
    @viewport.resize(x, y)

  setupNodesListener: () ->
    for node_id, nodes of @nodes
      for node in nodes
        @setupNodeListener(node)

  setupNodeListener: (node) ->
    node.onStateChange () =>
      for n in @nodes[node.id]
        n.state = node.state
        n.update()
  #@hightlightEdgesFromNode(node)



  #Call callback when any node is clicked
  onNodeClick: (callback) ->
    for node in @nodes
      @_onNodeClick(node, callback)

  _onNodeClick: (node, callback) ->
    node.on 'mousedown', () ->
      callback(node)

  hightlightEdgesFromNode: (node) ->
    for edge in @edges
      if edge.from == node.id
        edge.state = node.state
        edge.update()


class Graph
  constructor: (@group, @can_graph, data) ->
    @subgraphs = []
    @nodes = []
    @edges = []
    @load(data)

  load: (data) ->
    container_group = new Kinetic.Group(
      x: 0
      y: 0
      width: data.dimension.x
      height: data.dimension.y
    )
    @group.add(container_group)
    typeStyle = Ressources.style[data.type]
    customStyle = Ressources.style[data.clazz]
    style = $.extend({}, typeStyle, customStyle)
    container = new ContainerElement(container_group, style, @can_graph, '')
    container.update()

    for subgraph in data.subgraphs
      group = new Kinetic.Group(
        x: subgraph.position.x
        y: subgraph.position.y
        width: subgraph.dimension.x
        height: subgraph.dimension.y
      )
      @group.add(group)


      sub_g = new Graph(group, @can_graph, subgraph)
      @nodes = @nodes.concat sub_g.nodes #Add the list of nodes
      @edges = @edges.concat sub_g.edges #Add the list of edges
      @subgraphs.push(sub_g)

    for edge in data.edges
      @addEdge(edge)

    for node in data.nodes                         #Load all nodes
      x = node.position.x - node.dimension.x / 2
      y = node.position.y - node.dimension.y / 2
      @addNode(node.id, node.label, x, y, node.dimension.x, node.dimension.y, node.type, node.clazz)


  addNode: (id, text, x, y, width, height, type, clazz = '') ->
    typeStyle = Ressources.style[type.toLowerCase()]
    customStyle = Ressources.style[clazz.toLowerCase()]
    computedStyle = $.extend({}, typeStyle, customStyle)

    group = new Kinetic.Group({
      x: x
      y: y
      width: width
      height: height
    })

    @group.add(group)
    node = new NodeElement(group, computedStyle, @can_graph, text, id)
    node.update()

    @nodes.push(node)

  addEdge: (edge)   ->
    typeStyle = Ressources.style['arrow']
    customStyle = Ressources.style['']
    style = $.extend({}, typeStyle, customStyle)

    group = new Kinetic.Group({
      x: 0
      y: 0
    })
    @group.add(group)
    edge = new EdgeElement(group, style, @can_graph, edge.positions, edge.arrow, edge.from, edge.to)
    edge.update()

    @edges.push(edge)



  getWidth: () ->
    return @group.getWidth()

  getHeight: () ->
    return @group.getHeight()

  setPosition: (x, y) ->
    return @group.setPosition(x, y)