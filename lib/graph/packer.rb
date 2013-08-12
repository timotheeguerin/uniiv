class Packer
  def initialize
    @root = PackerNode.new
  end


  def find_node(root, width, height)
    if root.used
      node = find_node(root.right, width, height)
      if node.nil?
        find_node(root.down, width, height)
      else
        node
      end
    elsif width <= root.width and height <= root.height
      return root
    else
      nil
    end
  end

  def split_node(node, width, height)
    node.used = true
    node.down = PackerNode.new(node.x, node.y + height, node.width, node.height - height)
    node.right = PackerNode.new(node.x + width, node.y, node.width - width, height)
    node
  end

  def grow_node(width, height)
    should_grow_right = (@root.height >= (@root.width + width))
    should_grow_down = (@root.width >= (@root.height + height))


    if should_grow_right
      grow_right(width, height)
    elsif should_grow_down
      grow_down(width, height)
    else
      grow_right(width, height)
    end
  end

  def grow_right(width, height)
    @root.height = height if @root.height < height
    used = @root.used
    right = PackerNode.new(@root.width, 0, width, @root.height)
    @root = PackerNode.new(0, 0, @root.width + width, @root.height, right, @root)
    @root.used = used
    node = find_node(@root, width, height)

    if node.nil?
      nil
    else
      split_node(node, width, height)
    end
  end

  def grow_down(width, height)

    @root.width = width if @root.width < width
    used = @root.used
    down = PackerNode.new(0, @root.height, @root.width, height)
    @root = PackerNode.new(0, 0, @root.width, @root.height + height, @root, down)
    @root.used = used

    node = find_node(@root, width, height)

    if node.nil?
      nil
    else
      split_node(node, width, height)
    end
  end

  def pack_graph(graph, margin)
    sorted_graphs = graph.subgraphs.sort do |x, y|
      y.level <=> x.level
    end

    sorted_graphs.each do |subgraph|
      width = subgraph.dimension.x + margin
      height = subgraph.dimension.y + margin
      node = find_node(@root, width, height)
      if node.nil?
        node = grow_node(width, height)
        subgraph.position.x = node.x
        subgraph.position.y = node.y
      else
        node = split_node(node, width, height)
        subgraph.position.x = node.x
        subgraph.position.y = node.y
      end
    end

    graph.dimension.x = @root.width - margin #+ 2 * margin
    graph.dimension.y = @root.height - margin #+ 2 * margin

    sorted_graphs.each do |subgraph|
      #subgraph.position.x += margin
      subgraph.position.y = graph.dimension.y - subgraph.dimension.y - subgraph.position.y #- margin
    end

  end
end

class PackerNode
  attr_accessor :x, :y, :used, :width, :height, :right, :down

  def initialize (x =0, y = 0, width = 0, height = 0, right = nil, down = nil)
    @x = x
    @y = y
    @width = width
    @height = height
    @right = right
    @down = down
    @used = false
  end
end
