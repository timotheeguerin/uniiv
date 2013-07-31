class Point
  @x = 0
  @y = 0

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def self.from_array(array)
    x = array[0]
    y = array[1]
    Point.new(x, y)
  end
end