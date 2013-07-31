require 'graph/point'

class Node
  def initialize(id, label, position = Point.new, dimension= Point.new)
    @id = id
    @label = label
    @position = position
    @dimension = dimension

    if id.match /op_*/
      @type = 'OP'
    else
      @type = 'NODE'
    end

  end

  def self.from_graphviz_node(node_id, node)
    pos_array = node[:pos].point
    width = node[:width].source.to_f * 72
    height = node[:height].source.to_f * 72
    dimension = Point.new(width, height)
    position = Point::from_array(pos_array)
    label = node[:label].source
    Node.new(node_id, label, position, dimension)
  end
end