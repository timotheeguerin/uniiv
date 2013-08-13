class TestController < ApplicationController
  def index
    while check
      puts 'Checking'
    end
    while check_null_parent
      puts 'Checking null parent'
    end
  end

  def remove_dup
    nodes = Course::Node.all

  end

  def check
    nodes = Course::Node.all
    nodes.each do |node|

      nodes.each do |n|
        if node_same?(n, node) and n.id != node.id
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

  def node_same?(n1, n2)
    if n1.operation == NodeOperation::NODE || n2.operation == NodeOperation::NODE
      n1.to_s == n2.to_s
    else
      if (n1.id == 143 or n2.id == 143) and (n1.id ==125 or n2.id==125)
        puts '=======================NODE========================='
      end
      n1.nodes.each do |n|
        puts 'INCLU: ' + n2.nodes.include?(n).to_s if (n1.id == 143 or n2.id == 143) and (n1.id ==125 or n2.id==125)
        return false unless n2.nodes.include?(n)
      end
      true
    end
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
