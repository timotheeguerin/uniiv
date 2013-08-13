class TestController < ApplicationController
  def index
    #Change the course::node format
    course_nodes = Course::Node.all
    course_nodes.each do |node|
      parent = node.parent
      node.parents << parent unless parent.nil?
    end
  end
end
