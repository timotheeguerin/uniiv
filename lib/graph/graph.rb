require 'graph/point'
require 'graph/node'

class Graph
  attr_accessor :nodes, :edges, :position, :dimension

  def initialize (name ='', position = Point.new, dimension = Point.new, nodes = [], edges = [])
    @position = position
    @dimension = dimension
    @name = name
    @subgraphs = []
    @edges = edges
    @nodes = nodes
  end

  def add_graph(g)
    @subgraphs << g
    g
  end

  def self.from_dot(dot_graph, nodes)
    rect = dot_graph[:bb].to_ruby

    g_pos = Point::pos_from_array(rect)
    dimension = Point::dim_from_array(rect)

    g = Graph.new('', g_pos, dimension)

    dot_graph.each_node do |node_id, node|
      state = nodes[node_id][:state]
      n = Node::from_graphviz_node(node_id, node, g, state)
      g.nodes << n
    end

    dot_graph.each_edge do |edge|

      position = edge[:pos].to_s
      spline = Spline::from_dot(position) - g.position
      g.edges << spline
    end

    dot_graph.each_graph do |dot_subgraph_id, dot_subgraph|
      g.add_graph(Graph::from_dot(dot_subgraph, nodes))
    end
    g
  end


end