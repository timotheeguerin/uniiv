require 'graph/node'
require 'graph/spline'
require 'graph/graph'
require 'graph/dot_graph'
require 'graph/packer'


class GraphController < ApplicationController
  include GraphHelper

  def show

  end

  def user_data
    graphs_json = []
    nodes = {}

    style = JSON.parse(open("#{Rails.root}/app/assets/test/test.json").read)
    margin = style[:margin]
    padding = style[:padding]
    margin = 30 if margin.nil?
    padding = 15 if padding.nil?

    current_user.programs.each do |program|
      prg_graph = Graph.new(program.name)
      program.groups.each do |group|
        dot_graph = generate_graph_from_group(group)
        puts '------------------------------------'
        puts dot_graph.output
        nodes = nodes.merge(dot_graph.nodes)
        graph = generate_graph_from_dot(dot_graph.output, nodes, group.get_requirement_level)
        unless graph.dimension.x == 0 and graph.dimension.y == 0
          graph.type = 'group'
          graph.add_padding(padding)
          prg_graph.subgraphs << graph
        end
      end
      p = Packer.new
      prg_graph.type = 'program'
      p.pack_graph(prg_graph, margin)
      prg_graph.add_padding(padding)
      graphs_json << prg_graph
    end


    json = {}


    json[:style] = style
    json[:graphs] = graphs_json

    render :json => json.to_json
  end

  def generate_graph_from_group(group)
    g = GraphViz.new(:G, :type => :digraph, :concentrate => true, :strict => true, :label => group.name)
    dot_graph = DotGraph.new(g, current_user)
    dot_graph.load_from_group(group)

    dot_graph
  end

  def generate_graph_from_dot(dot, nodes, level = 0)

    json = {}
    GraphViz.parse_string(dot) do |g|
      puts 'LEVEL: ' + g[:label].to_s + ' -  ' + level.to_s
      json = Graph::from_dot(g, nodes, level)
    end
    json
  end

end
