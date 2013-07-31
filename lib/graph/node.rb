require 'graph/point'

class Node
  def initialize(id, label, position = Point.new)
    @id = id
    @label = label
    @position = position

    if id.match /op_*/
      @type = 'OP'
    else
      @type = 'NODE'
    end

  end

  def self.from_graphviz_node(node_id, node)
    pos_array = node[:pos].point
    position = Point::from_array(pos_array)
    label = node[:label].source
    Node.new(node_id, label, position)
  end
end