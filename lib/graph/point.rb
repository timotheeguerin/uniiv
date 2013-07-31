class Point
  @x = 0
  @y = 0

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def self.from_array(array)
    if array.size == 2 #Format [x,y]
      x = array[0]
      y = array[1]
    elsif array.size == 4 #Format [0,0,x,y]
      x = array[2]
      y = array[3]
    end
    Point.new(x, y)
  end

end