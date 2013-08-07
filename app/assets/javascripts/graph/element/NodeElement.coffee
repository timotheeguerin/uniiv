#=require graph/element/LabelElement

class NodeElement extends LabelElement
  constructor: (group, style, graph, label, id) ->
    super group, style, graph, label
    @id = id

  toString: () ->
    return @id + ' : ' + @label

window.NodeElement = NodeElement
