State =
  DEFAULT: 0
  HOVER: 1
  ACTIVE: 2

class GraphElement
  constructor: (@group, @style, @graph) ->
    @ishover = false
    @state = State.DEFAULT

    @on 'mouseenter', () =>
      @ishover = true
      @state = State.HOVER
    @on 'mouseleave', () =>
      @ishover = false
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

  update: ->
    switch @state
      when State.DEFAULT
        @applyStyle(@style.normal)
      when State.HOVER
        @applyStyle(@style.normal, @style.hover)
      when State.ACTIVE
        @applyStyle(@style.normal, @style['active'])
      else
        @applyStyle(@style.normal)
    @graph.update()

  applyStyle: (defaultStyle, stateStyle) ->
    style = $.extend(true, {}, defaultStyle, stateStyle)
    @computeStyle(style)

  computeStyle: (style) ->

  onStateChange: (callback) ->
    @on 'mouseenter', () ->
      callback()
    @on 'mouseleave', () ->
      callback()
    @on 'mousedown', () ->
      callback()
    @on 'mouseup', () ->
      callback()

#Get class accessible to other file
window.GraphElement = GraphElement
