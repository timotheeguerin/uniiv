class CourseExpr < ActiveRecord::Base
  belongs_to :node, :class_name => CourseNode

  def to_s
    id.to_s + ': ' + node.to_s
  end

  def display_name
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
end
