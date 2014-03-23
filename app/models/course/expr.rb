class Course::Expr < ActiveRecord::Base
  belongs_to :node, :class_name => Course::Node

  has_many :courses_pre, :class_name => Course::Course, :foreign_key => 'prerequisite_id'
  has_many :courses_co, :class_name => Course::Course, :foreign_key => 'corequisite_id'

  def check_destroy
    if courses_co.empty? and courses_pre.empty?
      destroy
    end
  end

  def to_s
    id.to_s + ': ' + node.to_s
  end

  def to_input
    node.to_input
  end

  def name
    to_s
  end

  def to_html
    node.to_html
  end

  def self.parse(string, subject_requirements = [])
    nodes = Course::Node.parse(string)
    return nil if nodes.nil?
    if nodes.size == 0
      node = Course::Node.new
      node.operation = NodeOperation::AND
    else
      node = nodes[0]
    end

    if node.operation == NodeOperation::OR
      tmp_node = node
      node = Course::Node.new
      node.nodes << tmp_node
      node.operation = NodeOperation::AND
    end
    node.subject_requirement_nodes = subject_requirements
    expr = Course::Expr.new
    if nodes != nil
      expr.node = node
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
        node_id = n.id_to_s
        subnode_id = sub_node.id_to_s
        edges.push({subnode_id => node_id})

        if sub_node.operation != NodeOperation::NODE
          queue << sub_node
        end
      end
    end
    edges
  end

  def count_requirements
    node.count_requirements
  end

  def requirements_completed?(scenario, term = nil)
    return true if node.nil?
    node.requirements_completed?(scenario, term)
  end

  def get_complexity
    if node.nil?
      0
    else
      node.get_complexity
    end
  end

  def list_dependencies
    node.list_dependencies
  end

  def as_json(options={})
    hash = super(:except => [:created_at, :updated_at])
    hash[:node] = node.as_json
    hash
  end
end
