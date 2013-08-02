require 'graph/node'
require 'graph/spline'
require 'graph/graph'

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
    calulate_graph_from_group(g, g, group, map, {}, {})
    # Create two nodes


    result = ''
    # Create an edge between the two nodes
    g.output(:dot => String)

  end

  def calulate_graph_from_group(main_graph, g, group, map, in_graph, out)

    #Add all course and operation nodes
    group.courses.each do |course|
      course_id = course.id_to_s
      unless map.has_key?(course_id)
        course_node = g.add_node(course_id)
        course_node[:label] = course.get_dot_name
        course_node[:shape] = 'circle'
        map[course_id] = course_node
        in_graph[course_id] = true
      end
      prerequisite = course.prerequisite
      unless prerequisite.nil?
        operations = prerequisite.get_all_operations
        operations.each do |op|
          op_id = op.id_to_s
          unless   map.has_key?(op_id)
            op_node = nil
            if op.is_linking_one_course?(in_graph)
              op_node = g.add_node(op_id)
              in_graph[op_id] = true
            else
              op_node = main_graph.add_node(op_id)
              out[op_id] = true
            end

            op_node[:label] = op.operation
            op_node[:shape] = 'circle'
            map[op_id] = op_node
          end
        end
        subcourses = prerequisite.get_all_courses
        subcourses.each do |subcourse|
          subcourse_id = subcourse.id_to_s
          unless map.has_key?(subcourse_id)
            subcourse_node = main_graph.add_node(subcourse_id)
            subcourse_node[:label] = subcourse.get_dot_name
            subcourse_node[:shape] = 'circle'
            map[subcourse_id] = subcourse_node
            out[subcourse_id] = true
          end
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
            if out[k] or out[v]
              main_graph.add_edge(node1, node2)
            else
              g.add_edge(node1, node2)
            end
          end
        end
      end
    end

    group.subgroups.each do |subgroup|
      subgraph_name = 'cluster_'+subgroup.id.to_s
      subgraph = g.add_graph(subgraph_name)
      calulate_graph_from_group(main_graph, subgraph, subgroup, map, in_graph, out)
    end
  end


  def generate_json_from_dot(dot)
    json = {}
    nodes = []
    edges = []
    json['nodes'] = nodes
    json['edges'] = edges

    GraphViz.parse_string(dot) do |g|
      json = Graph::from_dot(g)
    end

    json
  end

end
