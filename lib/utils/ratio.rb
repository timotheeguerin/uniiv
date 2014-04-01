module Utils
  class Ratio
    def initialize(ratio, coefficient=1)
      @ratio = ratio
      @coefficient = coefficient
    end

    def value
      @ratio * @coefficient
    end

    def percent
      @ratio * 100
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
  end
end