#=require kineticjs-viewport
#=require graph/element/GraphElement
#=require graph/element/ContainerElement

resizeCanvasContainer = () ->
  newheight = $(window).height() - 40;
  $("#canvas-container").height(newheight)


$(document).ready ->
  resizeCanvasContainer()
  canvas_container = $('#canvas-container')
  sidebar_loader = $("#sidebar_loader")
  sidebar_info = $("#graph_sidebar_info")
  sidebar_info.on 'click', 'a', (e) ->
    url = $(this).attr('href')
    node_id = 'c_' + $(this).attr('data-id')
    loadCourse(node_id, url + '/graph/embed')
    graph.update()
    e.preventDefault();

  if canvas_container?
    graph = new CanGraph({
      container: 'canvas-container'
      loading_container: 'graph_loader'
    })

    graph_data_url = canvas_container.attr('data-url')
    graph.load graph_data_url, () ->
      graph.update()
      graph.onNodeClick (node) ->     #When we click on a node it load information on the side
        name = node.id
        id = name.substring(2)
        type = name.split('_', 2)[0]
        if type == 'c'
          sidebar_loader.show()
          loadCourse(name, '/course/' + id + '/graph/embed')


    $(window).resize () ->
      resizeCanvasContainer()
      graph.resize()
  loadCourse = (node_id, url) ->
    sidebar_loader.show()
    graph.clear_nodes_hightlited()
    graph.highlight_node(node_id)
    $.get(url).success (data) ->
      sidebar_info.html(data)
      sidebar_loader.hide()
      sidebar_info.show()


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
    @highlited_nodes = []

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

    totalWidth = @viewport.canvasSize.x if totalWidth < @viewport.canvasSize.x
    maxHeight = @viewport.canvasSize.y if maxHeight < @viewport.canvasSize.y
    @container.setSize(totalWidth, maxHeight)
    @viewport.resizeLayer(@container.getWidth(), @container.getHeight())
    @viewport.autoResizeBackground()
    @container.setSize(@viewport.layerSize.x, @viewport.layerSize.y)


    graphX = (@container.getWidth() - totalWidth) / 2 + margin
    for graph in @graphs
      x = graphX
      y = (@container.getHeight() - graph.getHeight()) / 2
      graph.setPosition(x, y)
      graphX += graph.getWidth() + margin

    @viewport.zoom_to_min()
    @update();

  update: ->
    @viewport.update()

  resize: ()    ->
    html_container = $('#' + @options.container)
    x = html_container.width()
    y = html_container.height()
    @viewport.resize(x, y)

  setupNodesListener: () ->
    for node_id, nodes of @nodes
      if(nodes.length > 1)  #Register the listener only of there are multiple course with the same id
        for node in nodes
          @setupNodeListener(node)

  setupNodeListener: (node) ->
    node.onStateChange () =>
      for n in @nodes[node.id]
        n.state = node.state
        n.update()


  #Call callback when any node is clicked
  onNodeClick: (callback) ->
    for k, nodes of @nodes
      for node in nodes
        @_onNodeClick(node, callback)

  _onNodeClick: (node, callback) ->
    node.on 'mousedown', () ->
      callback(node)

  hightlightEdgesFromNode: (node) ->
    for edge in @edges
      if edge.from == node.id
        edge.state = node.state
        edge.update()

  clear_nodes_hightlited: () ->
    for node in @highlited_nodes
      node.highlight(false)
    @highlited_nodes = []

  highlight_node: (node_id) ->
    for node in @nodes[node_id]
      node.highlight(true)
      @highlited_nodes.push(node)

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