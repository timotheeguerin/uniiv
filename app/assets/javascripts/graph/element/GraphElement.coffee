State =
  DEFAULT: 0
  HOVER: 1
  ACTIVE: 2
  HIGHLIGHTED: 3

class GraphElement
  constructor: (@group, @style, @graph) ->
    @ishover = false
    @ishighlighted = false
    @state = State.DEFAULT
    @computed_style = {}

    @computed_style.default = @style['normal']
    @computed_style.hover = $.extend({}, @style['normal'], @style['hover'])
    @computed_style.active = $.extend({}, @computed_style.hover, @style['active'])
    @computed_style.highlighted = $.extend({}, @computed_style.active, @style['highlighted'])
    @computed_style.highlighted_hover = $.extend({}, @computed_style.hover, @style['highlighted'])

    unless (@style.onlydefault? and @style.onlydefault)
      @on 'mouseenter', () =>
        @ishover = true
        @state = State.HOVER
      @on 'mouseleave', () =>
        @ishover = false
        if @ishighlighted
          @state = State.HIGHLIGHTED
        else
          @state = State.DEFAULT
      @on 'mousedown', () =>
        @state = State.ACTIVE
      @on 'mouseup', () =>
        if @ishover
          @state = State.HOVER
        else
          @state = State.DEFAULT


  on: (event, callback) ->
    @group.on(event, () =>
      callback()
      @update()
    )
    @remapRedrawEvent()

  update: ->
    switch @state
      when State.DEFAULT
        @changeCursor('default')
        @applyStyle(@computed_style.normal)
      when State.HOVER
        @changeCursor(@style.cursor)
        if @ishighlighted
          @applyStyle(@computed_style.highlighted_hover)
        else
          @applyStyle(@computed_style.hover)
      when State.ACTIVE
        @changeCursor(@style.cursor)
        @applyStyle(@computed_style.active)
      when State.HIGHLIGHTED
        @applyStyle(@computed_style.highlighted)
      else
        @applyStyle(@computed_style.normal)


  applyStyle: (style) ->
    @computeStyle(style)

  changeCursor: (cursor)->
    if cursor?
      document.body.style.cursor = cursor
    else
      document.body.style.cursor = 'default'

  computeStyle: (style) ->

  onStateChange: (callback) ->
    @on 'mouseenter mouseleave mousedown mouseup', () ->
      callback()

  remapRedrawEvent: () ->
    @group.off 'mouseenter.redraw mouseleave.redraw mousedown.redraw mouseup.redraw'
    @group.on 'mouseenter.redraw mouseleave.redraw mousedown.redraw mouseup.redraw', () =>
      @graph.update()

  highlight: (val) ->
    @ishighlighted = val
    if val
      @state = State.HIGHLIGHTED
    else
      @state = State.DEFAULT
    @update()
#Get class accessible to other file
window.GraphElement = GraphElement
