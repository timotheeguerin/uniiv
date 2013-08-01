require 'graph/point'

class Spline
  def initialize(array = [], arrow)
    @positions = array
    @arrow = arrow
  end


  def self.from_dot positions
    position_array = []
    array = positions.split(' ')
    arrow = Point.new
    (array).each do |pos|
      coor = pos.split(',')
      if coor.size == 3 #Arrow side
        arrow = 0
        position_array << Point.new(coor[1], coor[2])
      elsif coor.size == 2
        position_array << Point.new(coor[0], coor[1])
      end
    end
    Spline.new(position_array, arrow)
  end
end