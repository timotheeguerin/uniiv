module Utils
  class Ratio
    attr_accessor :ratio, :coefficient

    def initialize(ratio, coefficient=1)
      self.ratio = ratio
      self.coefficient = coefficient
    end

    def ratio=(r)
      if r > 1
        r = 1
      end
      @ratio = r.to_f
    end

    def coefficient=(c)
      @coefficient = c.to_f
    end

    def value
      @ratio * @coefficient
    end

    def percent
      @ratio * 100
    end

    def +(other)
      output = Utils::Ratio.empty
      if other.is_a? Utils::Ratio
        output.ratio = (value+other.value)/(@coefficient+other.coefficient)
        output.coefficient = @coefficient + other.coefficient
      end
      output
    end

    def <(other)
      @ratio < other.ratio
    end

    def >(other)
      @ratio > other.ratio
    end

    def ==(other)
      @ratio == other.ratio
    end

    def full?
      @ratio == 1
    end

    def empty?
      @ratio == 0
    end

    def self.full
      Utils::Ratio.new(1)
    end

    def self.empty
      Utils::Ratio.new(0)
    end

    #Create a ratio with ratio =0 and coef = 0
    def self.zero
      Utils::Ratio.new(0, 0)
    end

    def to_s
      @ratio.to_s
    end
  end
end