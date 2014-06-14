#=require kineticjs-viewport
#=require graph/element/GraphElement
#=require graph/element/ContainerElement

resizeCanvasContainer = () ->
  newheight = $(window).height() - 75;
  $("#canvas-container").parent().height(newheight);
  $("#canvas-container").parent().parent().height(newheight);


$(document).ready ->
  resizeCanvasContainer()
  canvas_container = $("#canvas-container")
  sidebar_loader = $("#sidebar_loader")
  sidebar_info = $("#graph_sidebar_info .content")
  graph_reload = $('#graphreload')
  semester_id = ''
  year = ''
  if canvas_container.length > 0
    semester_id = canvas_container.attr('data-semester')
    year = canvas_container.attr('data-year')
    graph = new CanGraph({
      container: 'canvas-container'
      loading_container: 'graph_loader'
      zoomin_button: '#zoomin_graph'
      zoomout_button: '#zoomout_graph'
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
      graph.onGraphClick (graph) ->     #When we click on a node it load information on the side
        array = graph.id.split('_', 2)
        type = array[0]
        id = array[1]
        sidebar_loader.show()
        if type == 'p'
          loadProgram(id)
        else if type == 'g'
          loadGroup(id)

    sidebar_info.on 'click', 'a', (e) ->
      url = $(this).attr('href')
      type = $(this).attr('data-type')
      console.log('type:' + type)
      switch type
        when  "ext" #load the link normaly
          return true
        when "course"
          node_id = 'c_' + $(this).attr('data-id')
          loadCourse(node_id, url + '/graph/embed')
        else
          console.log('load link')
          load_sidebar(url)

      graph.update()
      e.preventDefault()

    $(window).resize () ->
      resizeCanvasContainer()
      graph.resize()
    $(document).on 'formAjaxComplete', '#graph_sidebar_info', (evt, data) ->
      console.log('reiuhroehs: ' + JSON.stringify(data))
      if data.url?
        load_sidebar(data.url)
      else
        reload_graph_info()
      #graph_reload.show()
      location.reload()


  reload_graph_info = () ->
    url = sidebar_info.attr('data-url')
    if url? and url != ''
      load_sidebar(url)

  loadCourse = (node_id, url) ->
    sidebar_loader.show()
    graph.clear_nodes_hightlited()
    graph.highlight_node(node_id)
    load_sidebar(url)

  loadProgram = (program_id) ->
    url = '/program/' + program_id + '/graph/embed'
    load_sidebar(url)

  loadGroup = (program_id) ->
    url = '/group/' + program_id + '/graph/embed'
    load_sidebar(url)

  load_sidebar = (url) ->
    sidebar_info.attr('data-url', url)
    $.get(url, {
      semester: semester_id
      year: year
    }).success (data) ->
      remove_tooltip(sidebar_info)
      sidebar_info.html(data)
      sidebar_loader.hide()
      sidebar_info.show()
      sidebar_info.parent().nanoScroller()
      $(document).trigger('ajaxloadhtml', [sidebar_info])


class Ressources
  @images: {}
  @style: {}

  @loadImageFromJson: (data) ->
    for k0, v0 of data.style #for all the class in the style
      for k, v of v0
        if(v.background? && v.background.image? && v.background.image.src?)
          @addImage(v.background.image.src)

  @addImage: (src) ->
    if(!@images[src]?)
      image = new Image()
      image.src = assets_path(src)
      @images[src] = image

  #Call the given function when all images are loaded
  @onLoadImage: (callback) ->
    loadedImages = 0
    numImages = Object.keys(@images).length
    #get num of sources
    console.log(@images)
    if numImages == 0
      console.log('no images')
      callback()
      return

    for src, image of @images
      image.onload = ()   ->
        if (++loadedImages >= numImages)
          callback()


class CanGraph
  constructor: (options) ->
    defaults = {
      container: 'canvas'
      loading_container: 'canvas-loading'
      zoomin_button: ''
      zoomout_button: ''
    }
    @options = $.extend({}, defaults, options)
    html_container = $('#' + @options.container)
    @viewport = new ViewPort({
      container: options.container,
      width: html_container.width()
      height: html_container.height()
      zoomin_button: @options.zoomin_button
      zoomout_button: @options.zoomout_button
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
      console.log 'loaded data'
      Ressources.loadImageFromJson (data)
      Ressources.style = data.style
      Ressources.onLoadImage => #Wait for the images to load
        console.log 'image loaded'
        @loadGraphs(data)
        @canvas_container.show()
        @loading_screen.hide() if @loading_screen?
        callback()
    , "json")

  loadGraphs: (data)->
    if(!data.graphs?)
      return
    margin = 30 #TODO load from style
    padding = 30
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
    @viewport.resizeLayer(@container.getWidth() + 2 * padding, @container.getHeight() + 2 * padding)
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

  onGraphClick: (callback) ->
    for graph in @graphs
      graph.onGraphClick(callback)
  #@_onGraphClick(graph, callback)

  _onGraphClick: (graph, callback) ->
    graph.onClickInfo () ->
      callback(graph)

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
    @container_element = null
    @data = data
    @id = data.id
    @load(data)

  load: (data) ->
    console.log(JSON.stringify(data.dimension))
    container_group = new Kinetic.Group(
      x: 0
      y: 0
      width: data.dimension.x
      height: data.dimension.y
    )
    @group.add(container_group)

    #Style
    typeStyle = Ressources.style[data.type]
    customStyle = Ressources.style[data.clazz]
    style = $.extend(true, {}, typeStyle, customStyle)

    #Style of the group
    @container_element = new ContainerElement(container_group, style, @can_graph, data.label)
    @container_element.update()

    #Load subgraphs
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

  onGraphClick: (callback) ->
    @onClickInfo(callback)
    for subgraph  in @subgraphs
      subgraph.onGraphClick(callback)

  onClickInfo: (callback) ->
    @container_element.onLabelClick () =>
      callback(@)

  addNode: (id, text, x, y, width, height, type, clazz = '') ->
    typeStyle = Ressources.style[type.toLowerCase()]
    customStyle = Ressources.style[clazz.toLowerCase()]
    computedStyle = $.extend(true, {}, typeStyle, customStyle)

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