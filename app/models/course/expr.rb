class Course::Expr < ActiveRecord::Base
  belongs_to :node, :class_name => Course::Node

  has_many :courses_pre, :class_name => Course::Course, :foreign_key => 'prerequisite_id'
  has_many :courses_co, :class_name => Course::Course, :foreign_key => 'corequisite_id'

  def to_s
    id.to_s + ': ' + node.to_s
  end

  def name
    to_s
  end

  def to_html
    node.to_html
  end

  def self.parse(string)
    nodes = Course::Node.parse(string)
    return nil if nodes.nil?
    expr = Course::Expr.new
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

  def requirements_completed?(user)
    return true if node.nil?
    node.requirements_completed?(user)
  end

  def as_json(options={})
    hash = super(:except => [:created_at, :updated_at])
    hash[:node] = node.as_json
    hash
  end
end
