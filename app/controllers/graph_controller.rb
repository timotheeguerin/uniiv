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
    completed_percent = (group.get_completition_ratio(current_user) * 100).round
    label = "#{group.name} (#{completed_percent}%)"
    g = GraphViz.new(:G, :type => :digraph, :strict => true, :label => label, :fontsize => 20)
    dot_graph = DotGraph.new(g, current_user)
    content_graph = g.add_graph('cluster_' + group.name)
    content_graph[:label] = ''
    dot_graph.load_from_group(group, content_graph)

    dot_graph
  end

  def generate_graph_from_dot(dot, nodes, level = 0)

    json = {}
    GraphViz.parse_string(dot) do |g|
      json = Graph::from_dot(g, nodes, level, true)
    end
    json
  end

end
