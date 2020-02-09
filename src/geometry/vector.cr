module Geometry
  struct Vector
    property :x, :y

    def initialize(@x : Int32, @y : Int32)
    end

    def ==(other : Vector)
      x == other.x && y == other.y
    end

    def modulus
      Math.hypot(x, y)
    end

    def cross_product(other : Vector)
      x * other.y - y * other.x
    end

    def scalar_product(other : Vector)
      x * vector.x + y.vector.y
    end

    def collinear_with?(other : Vector)
      cross_product(other) == 0
    end

    def +(other : Vector)
      Vector.new(x + other.x, y + other.y)
    end

    def -(other : Vector)
      self + (-1) * other
    end

    def *(scalar : Int32)
      Vector.new(x * scalar, y * scalar)
    end

    def coerce(scalar : Int32)
      [self, scalar]
    end
  end
end
