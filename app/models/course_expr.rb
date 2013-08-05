class CourseExpr < ActiveRecord::Base
  belongs_to :node, :class_name => CourseNode

  def to_s
    id.to_s + ': ' + node.to_s
  end

  def name
    to_s
  end

  def self.parse(string)
    nodes = CourseNode.parse(string)
    return nil if nodes.nil?
    expr = CourseExpr.new
    if nodes != nil
      expr.node = nodes[0]
    end
    return expr
  end

  #Return all the operations node in this expression
  def get_all_operations
    list = []
    queue = Queue.new
    queue << node
    until queue.empty?
      n = queue.pop
      puts "NODE: " + n.to_s
      if n.operation != NodeOperation::NODE
        list.push(n)
        n.nodes.each do |sub_node|
          queue << sub_node
        end
      end
    end
    list
  end

  def get_all_courses
    list = []
    queue = Queue.new
    queue << node
    until queue.empty?
      n = queue.pop
      if n.operation == NodeOperation::NODE
        list.push(n.course)
      else
        n.nodes.each do |sub_node|
          queue << sub_node
        end
      end
    end
    list
  end

  #Return all the operations node in this expression
  def get_all_edges(course)
    edges = []
    edges.push({node.id_to_s => course.id_to_s})
    queue = Queue.new
    queue << node

    until queue.empty?
      n = queue.pop
      n.nodes.each do |sub_node|
        node_id = node.id_to_s
        subnode_id = sub_node.id_to_s
        edges.push({subnode_id => node_id})

        if sub_node.operation != NodeOperation::NODE
          queue << sub_node
        end
      end
    end
    edges
  end

  def requirements_completed?(user)
    node.requirements_completed?(user)
  end
end
