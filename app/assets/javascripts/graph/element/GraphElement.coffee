State =
  DEFAULT: 0
  HOVER: 1
  ACTIVE: 2

class GraphElement
  constructor: (@group, @style, @graph) ->
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
    @on 'mouseup', () =>
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
        @applyStyle(@style.normal, @style['active'])
      else
        @applyStyle(@style.normal)
    @graph.update()

  applyStyle: (defaultStyle, stateStyle) ->
    style = $.extend(true, {}, defaultStyle, stateStyle)
    @computeStyle(style)

  computeStyle: (style) ->

#Get class accessible to other file
window.GraphElement = GraphElement
