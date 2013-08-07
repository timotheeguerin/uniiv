State =
  DEFAULT: 0
  HOVER: 1
  ACTIVE: 2

class GraphElement
  constructor: (@group, @style, @graph) ->
    @ishover = false
    @state = State.DEFAULT
    unless (@style.onlydefault? and @style.onlydefault)
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
      @graph.update()
    )

  update: ->
    switch @state
      when State.DEFAULT
        @changeCursor('default')
        @applyStyle(@style.normal)
      when State.HOVER
        @changeCursor(@style.cursor)
        @applyStyle(@style.normal, @style.hover)
      when State.ACTIVE
        @changeCursor(@style.cursor)
        @applyStyle(@style.normal, @style['active'])
      else
        @applyStyle(@style.normal)


  applyStyle: (defaultStyle, stateStyle) ->
    style = $.extend(true, {}, defaultStyle, stateStyle)
    @computeStyle(style)

  changeCursor: (cursor)->
    if cursor?
      document.body.style.cursor = cursor
    else
      document.body.style.cursor = 'default'

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
