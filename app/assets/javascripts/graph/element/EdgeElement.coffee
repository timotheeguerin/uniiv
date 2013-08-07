#=require graph/element/GraphElement

class EdgeElement extends  GraphElement
  constructor: (group, style, graph, @points, @side, @from, @to) ->
    super group, style, graph

  computeStyle: (style) ->
    spline = @group.get(".spline")[0]
    triangle = @group.get(".triangle")[0]
    if(!spline?)
      spline = new Kinetic.Spline({
        points: @points,
        stroke: 'black',
        strokeWidth: 1,
        lineCap: 'round',
        tension: 1
        name: 'spline'
      })
      @group.add(spline)

    angle = 30
    length = 14
    angle = style.angle if style.angle?
    length = style.length if style['length']?
    if not triangle?
      if(@side == 0)   #0 Begining, 1: End, 2: Both
        a = @points[0]
        b = @points[1]
        triangle = @createTriangle(a, b, angle, length)
        @group.add(triangle)

    if(style?)
      if(style.color?)
        spline.setStroke(style.color)
        triangle.setStroke(style.color)
        triangle.setFill(style.color)
      if(style.width?)
        spline.setStrokeWidth(style.width)
        triangle.setStrokeWidth(style.width)

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
        #context.quadraticCurveTo(a.x, a.y, d.x, d.y);
        context.lineTo(d.x, d.y)
        context.closePath();
        canvas.fillStroke(this);
      fill: 'black'
      name: 'triangle'
    });
    return poly


  angle: (a, b) ->
    v = {
      x: a.x - b.x
      y: a.y - b.y
    }
    return Math.acos((v.x) / Math.sqrt(Math.pow(v.x, 2) + Math.pow(v.y, 2)))


window.EdgeElement = EdgeElement
