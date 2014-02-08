module Graph
  class Spline
    def initialize(from, to, array = [], arrow)
      @positions = array
      @arrow = arrow
      @from = from
      @to = to
      #check_spline_touch()
    end

    def check_spline_touch
      if @positions.size > 1
        (1...@positions.size).each do |i|
          prev = @positions[i-1]
          cur = @positions[i]
          if @arrow[i] == 1
            prev[-1] = cur[1].clone
          else
            prev[-1] = cur[0].clone
          end
        end
      end
    end

    def self.from_dot edge
      positions = edge[:pos].to_s.gsub("\\\\r\\n", '')
      from = edge.tail_node
      to = edge.head_node


      arrow = 0
      #In case there are multiple edges to display
      spline_array = positions.split(';')

      position_arrays = []
      arrows = []
      coun = 0
      spline_array.each do |spline|
        array = spline.split(' ') #Split points
        position_array = []
        arrow = 0
        array.each do |pos|
          coor = pos.split(',')
          if coor.size == 3 #Arrow side
            arrow = 1
            position_array << Point.new(coor[1].to_f.round, coor[2].to_f.round)
          elsif coor.size == 2

            x = coor[0]
            y = coor[1]
            if x[0] == '"'
              x = x[1..-1]
            end
            if y[-1] == '"'
              y = y[0..-2]
            end
            p = Point.new(x.to_f.round, y.to_f.round)
            position_array << p
          end
        end
        arrows << arrow
        position_arrays.push(position_array)
        coun += 1
      end
      Spline.new(from, to, position_arrays, arrows)
    end

    def +(point)
      @positions.each do |array|
        array.each do |p|
          p += point
        end
      end
      self
    end

    def -(point)
      @positions.each do |array|
        array.each do |p|
          p -= point
        end
      end
      self
    end
  end
end