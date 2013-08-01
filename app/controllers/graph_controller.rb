require 'graph/node'
require 'graph/spline'

class GraphController < ApplicationController
  include GraphHelper

  def index
    group = ProgramGroup.find(params[:id])

    output = generate_graph_from_group(group)
    @dot = output
    graph_json = generate_json_from_dot(output)
    json = {}
    style = JSON.parse(open("#{Rails.root}/app/assets/test/test.json").read)

    json[:style] = style
    json[:graph] = graph_json

    @json = json.to_json

  end

  def data
    group = ProgramGroup.find(params[:id])

    output = generate_graph_from_group(group)
    @dot = output
    graph_json = generate_json_from_dot(output)
    json = {}
    style = JSON.parse(open("#{Rails.root}/app/assets/test/test.json").read)

    json[:style] = style
    json[:graphs] = [graph_json]

    render :json => json.to_json
  end


  def generate_graph_from_group(group)
    g = GraphViz.new(:G, :type => :digraph, :concentrate => true, :strict => true)

    map ={}
    #Add all course and operation nodes
    group.courses.each do |course|
      course_id = 'c_' + course.id.to_s
      course_node = g.add_node(course_id)
      course_node[:label] = course.get_short_name
      map[course_id]= course_node
      prerequisite = course.prerequisite
      unless prerequisite.nil?
        operations = prerequisite.get_all_operations
        operations.each do |op|
          op_id = 'op_' + op.id.to_s
          op_node = g.add_node(op_id)
          op_node[:label] = op.operation
          map[op_id] = op_node
        end
      end
    end


    group.courses.each do |course|
      prerequisite = course.prerequisite
      unless prerequisite.nil?
        edges = prerequisite.get_all_edges(course)
        edges.each do |hash|
          hash.each do |k, v|
            node1 = map[k]
            node2 = map[v]
            g.add_edge(node1, node2)
          end
        end
      end
    end


    # Create two nodes

    result = ''
    # Create an edge between the two nodes
    g.output(:dot => String)

  end

  def generate_json_from_dot(dot)
    json = {}
    nodes = []
    edges = []
    json['nodes'] = nodes
    json['edges'] = edges

    GraphViz.parse_string(dot) do |g|
      puts 'oisje: ' + g[:bb].to_ruby.to_s
      json[:dimension] = Point.from_array(g[:bb].to_ruby)

      g.each_node do |node_id, node|
        label = node[:label]
        position = node[:pos]
        nodes << Node::from_graphviz_node(node_id, node)

      end

      g.each_edge do |edge|

        position = edge[:pos].to_s
        spline = Spline::from_dot position
        edges << spline
      end
    end

    json
  end

end
