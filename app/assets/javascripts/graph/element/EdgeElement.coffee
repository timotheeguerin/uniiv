#=require graph/element/GraphElement

class EdgeElement extends  GraphElement
  constructor: (group, style, graph, @points, @sides, @from, @to) ->
    super group, style, graph
    @beziers = []
    @triangle = null

  computeStyle: (style) ->
    #beziers = @group.get(".bezier")
    #triangle = @group.get(".triangle")[0]
    if(not @beziers? or @beziers.length == 0)
      beziers = []
      i = 0
      for positions in @points
        points = positions
        if @sides[i] == 1
          points = positions.slice(1, positions.length)
        if points.length == 4
          a = points[0]
          b = points[3]
          line = @createLine(a, b)
          @beziers.push(line)
          @group.add(line)
        else
          for i in [1...points.length] by 3
            bezier = @drawBezier(i, points)
            @beziers.push(bezier)
            @group.add(bezier)
        i++


        angle = 30
    length = 14
    angle = style.angle if style.angle?
    length = style.length if style['length']?
    if not @triangle?
      i = 0
      for positions in @points
        if(@sides[i] == 1)   #0 Begining, 1: End, 2: Both
          a = positions[0]
          b = positions[positions.length - 1]
          @triangle = @createTriangle(a, b, angle, length)
          @group.add(@triangle)
        i++

    if(style?)
      if(style.color?)
        @triangle.setFill(style.color)
        for bezier in @beziers
          bezier.setStroke(style.color)
        @triangle.setStroke(style.color)
      if(style.width?)
        @triangle.setStrokeWidth(style.width)
        for bezier in @beziers
          bezier.setStrokeWidth(style.width)

  createLine: (a, b) ->
    line = new Kinetic.Line({
      points: [a, b]
    })
    line

  drawBezier: (i, points) ->
    #console.log JSON.stringify(points)
    bezier = new Kinetic.Shape({
      drawFunc: (canvas) ->
        #console.log('DRAW: ' + points.length + ' - ' + i)
        #console.log(JSON.stringify(points))
        context = canvas.getContext()
        context.beginPath()
        context.moveTo(points[i - 1].x, points[i - 1].y)
        context.bezierCurveTo(points[i].x, points[i].y, points[i + 1].x, points[i + 1].y, points[i + 2].x,
          points[i + 2].y);
        context.stroke()
        canvas.fillStroke(this)
      name: 'bezier'
      stroke: 'black'
    })
    return bezier

  createTriangle: (a, b, alpha, l) ->
    angle = @angle(b, a)
    beta = alpha * Math.PI / 180
    c = {
      x: parseFloat(a.x) + l * Math.cos(angle + beta / 2)
      y: parseFloat(a.y) + l * Math.sin(angle + beta / 2)
    }
    d = {
      x: parseFloat(a.x) + l * Math.cos(angle - beta / 2)
      y: parseFloat(a.y) + l * Math.sin(angle - beta / 2)
    }
    poly = new Kinetic.Shape({
      drawFunc: (canvas) ->
        context = canvas.getContext();
        context.beginPath();
        context.moveTo(a.x, a.y);
        context.lineTo(c.x, c.y);
        context.lineTo(d.x, d.y)
        context.closePath();
        canvas.fillStroke(this);
      fill: 'black'
      name: 'bezier'
    });
    return poly

  angle: (a, b) ->
    v = {
      x: a.x - b.x
      y: a.y - b.y
    }
    return Math.acos((v.x) / Math.sqrt(Math.pow(v.x, 2) + Math.pow(v.y, 2)))


window.EdgeElement = EdgeElement
