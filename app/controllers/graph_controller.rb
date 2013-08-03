require 'graph/node'
require 'graph/spline'
require 'graph/graph'
require 'graph/dot_graph'

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
    dot_graph = DotGraph.new(g)
    dot_graph.load_from_group(group)

    dot_graph.graph.output(:dot => String)

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
