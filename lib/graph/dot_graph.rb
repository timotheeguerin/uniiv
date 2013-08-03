class DotGraph
  attr_accessor :graph

  def initialize(graph)
    @nodes = {}
    @graph = graph
  end

  def load_from_group(group, graph = @graph)
    #Load all the group courses
    group.courses.each do |course|
      add_course(course, graph)
    end

    #Load all the dependency course not in any groups/subgroups
    group.courses.each do |course|
      prerequisite = course.prerequisite
      unless prerequisite.nil?

        subcourses = prerequisite.get_all_courses
        subcourses.each do |subcourse|
          puts 'Cour: ' + subcourse.id_to_s
          add_course(subcourse, graph, false) #Add all dependency ouside of the subgraph if applicable
        end
      end
    end

    group.courses.each do |course|
      prerequisite = course.prerequisite
      unless prerequisite.nil?
        operations = prerequisite.get_all_operations
        operations.each do |op|
          add_operation(op, graph)
        end
      end

    end
    group.courses.each do |course|
      prerequisite = course.prerequisite
      unless prerequisite.nil?
        edges = prerequisite.get_all_edges(course)
        edges.each do |hash|
          hash.each do |k, v|
            node1 = @nodes[k]
            node2 = @nodes[v]
            if node1[:in] && node2[:in]
              graph.add_edge(node1[:node], node2[:node])
            else
              @graph.add_edge(node1[:node], node2[:node])
            end
          end
        end
      end
    end

    #Load the subgroups recursively
    group.subgroups.each do |subgroup|
      subgraph_name = 'cluster_'+subgroup.id.to_s
      subgraph = graph.add_graph(subgraph_name)
      load_from_group(subgroup, subgraph)
    end

  end

  #Add course to graph
  def add_course(course, graph = @graph, in_graph = true)
    graph = @graph unless in_graph
    course_id = course.id_to_s

    unless @nodes.has_key?(course_id)
      puts 'Add: ' + course_id
      course_node = graph.add_node(course_id)
      course_node[:label] = course.get_dot_name
      course_node[:shape] = 'circle'
      @nodes[course_id] = {:node => course_node, :in => in_graph}
    end
  end

  def add_operation(operation, graph, in_graph = true)
    op_id = operation.id_to_s

    if in_graph
      nodes = get_course_out
      in_graph = false if operation.is_linking_one_course?(nodes)
    end
    graph = @graph unless in_graph
    unless  @nodes.has_key?(op_id)
      op_node = nil
      op_node = graph.add_node(op_id)
      op_node[:label] = operation.operation
      op_node[:shape] = 'circle'
      @nodes[op_id] = {:node => op_node, :in => in_graph}
    end
  end

  def get_course_out
    nodes = []
    @nodes.each do |k, node|
      unless node[:in]
        nodes << k
      end
    end
    nodes
  end

  def nodes_to_s
    result = ''
    @nodes.each do |k, node|
      result = result + k + ' => ' + node[:in].to_s + ', '
    end
    result
  end
end