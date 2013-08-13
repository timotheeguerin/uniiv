class TestController < ApplicationController
  def index
    while check
      puts 'Checking'
    end
    while check_null_parent
      puts 'Checking null parent'
    end
  end

  def check
    nodes = Course::Node.all
    nodes.each do |node|
      nodes.each do |n|
        if n.to_s == node.to_s and node.operation == NodeOperation::NODE and n.id != node.id
          puts 'TWO node same: ' + n.to_s + ' - '+ node.to_s
          n.exprs.each do |expr|
            puts 'Change expr'
            expr.node = node
            expr.save
          end
          n.parents.each do |parent|
            puts 'Change parents'
            node.parents << parent
            parent.nodes.delete(n)
            parent.save
          end
          n.destroy
          node.save
          return true
        end
      end
    end
    false
  end

  def check_null_parent
    nodes = Course::Node.all
    nodes.each do |node|
      if node.parents.size == 0 and node.exprs.size == 0
        puts 'NULL PARENT OR XPR'
        node.destroy
        return true
      end
    end
    exprs = Course::Expr.all
    exprs.each do |expr|
      if expr.courses_pre.size == 0 and expr.courses_co.size== 0
        expr.destroy
        return true
      end
    end
    false
  end
end
