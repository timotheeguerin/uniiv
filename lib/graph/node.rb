require 'graph/point'

class Node
  def initialize(id, position = Point.new)
    @id = id
    @position = position
  end

  def self.from_graphviz_node(node_id, node)
    pos_array = node[:pos].point
    position = Point::from_array(pos_array)
    Node.new(node_id, position)
  end
end