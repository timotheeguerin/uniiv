require 'graph/node'
require 'graph/spline'
require 'graph/graph'
require 'graph/dot_graph'

class GraphController < ApplicationController
  include GraphHelper

  def user_data
    graphs_json = []
    nodes = {}
    current_user.programs.each do |program|
      program.groups.each do |group|
        dot_graph = generate_graph_from_group(group)
        nodes = nodes.merge(dot_graph.nodes)
        graph = generate_graph_from_dot(dot_graph.output, nodes)

        graphs_json << graph


      end
    end


    json = {}
    style = JSON.parse(open("#{Rails.root}/app/assets/test/test.json").read)

    json[:style] = style
    json[:graphs] = graphs_json

    render :json => json.to_json
  end

  def generate_graph_from_group(group)
    g = GraphViz.new(:G, :type => :digraph, :concentrate => true, :strict => true)
    dot_graph = DotGraph.new(g, current_user)
    dot_graph.load_from_group(group)

    dot_graph
  end

  def generate_graph_from_dot(dot, nodes)
    json = {}
    GraphViz.parse_string(dot) do |g|
      json = Graph::from_dot(g, nodes)
    end
    json
  end

end
