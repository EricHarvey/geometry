module Geometry
  struct Point
    property :x, :y

    def self.new_by_array(array : Array(Int32))
      self.new(array[0], array[1])
    end

    def initialize(@x : Int32, @y : Int32)
    end

    def ==(other : Point)
      x == other.x && y == other.y
    end

    def to_vector
      Vector.new(x, y)
    end

    def advance_by(other : Vector)
      Point.new(x + other.x, y + other.y)
    end

    def distance_to(other : Point)
      distance(self, other)
    end
  end
end
