module Graph

  class Node
    attr_accessor :id, :label, :position, :dimension, :clazz, :type

    def initialize(id, label, position = Point.new, dimension= Point.new)
      @id = id
      @label = label
      @position = position
      @dimension = dimension
      @clazz = ''

      if id.match /op_*/
        @type = 'OP'
      else
        @type = 'NODE'
      end

    end

    def self.from_graphviz_node(node_id, node, graph, state = nil)

      pos_array = node[:pos].point
      width = node[:width].source.to_f * 72
      height = node[:height].source.to_f * 72
      dimension = Point.new(width, height)
      position = Point::dim_from_array(pos_array) - graph.position
      label = node[:label].source
      node = Node.new(node_id, label, position, dimension)
      unless state.nil?
        node.clazz = node.type + '_' + state
      end
      node
    end
  end
end