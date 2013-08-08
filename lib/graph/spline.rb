require 'graph/point'

class Spline
  def initialize(from, to, array = [], arrow)
    @positions = array
    @arrow = arrow
    @from = from
    @to = to
  end


  def self.from_dot edge
    positions = edge[:pos].to_s
    from = edge.tail_node
    to = edge.head_node

    position_array = []
    array = positions.split(' ') #Split points
    arrow = Point.new
    (array).each do |pos|
      coor = pos.split(',')
      if coor.size == 3 #Arrow side
        arrow = 0
        position_array << Point.new(coor[1].to_f.round, coor[2].to_f.round)
      elsif coor.size == 2
        x = coor[0].to_f.round
        y = coor[1].to_f.round
        if y[-1] == '"'
          y = y[0..-2]
        end
        p = Point.new(x, y)
        position_array << p
      end
    end
    Spline.new(from, to, position_array, arrow)
  end

  def +(point)
    @positions.each do |p|
      p += point
    end
    self
  end

  def -(point)
    @positions.each do |p|
      p -= point
    end
    self
  end
end