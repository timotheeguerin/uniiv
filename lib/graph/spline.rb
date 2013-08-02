require 'graph/point'

class Spline
  def initialize(array = [], arrow)
    @positions = array
    @arrow = arrow
  end


  def self.from_dot positions
    position_array = []
    array = positions.split(' ') #Split points
    arrow = Point.new
    (array).each do |pos|
      coor = pos.split(',')
      if coor.size == 3 #Arrow side
        arrow = 0
        position_array << Point.new(coor[1], coor[2])
      elsif coor.size == 2
        x = coor[0]
        y = coor[1]
        if y[-1] == '"'
          y = y[0..-2]
        end
        p = Point.new(x, y)
        position_array << p
        puts 'POINT: ' + p.to_s
      end
    end
    Spline.new(position_array, arrow)
  end
end