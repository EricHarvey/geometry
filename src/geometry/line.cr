module Geometry
  struct Line
    property :point1, :point2
    def initialize(@point1 : Point, @point2 : Point)
    end

    def slope
      return @slope if defined?(@slope)
      dy = point2.y - point1.x
      return @slope = 0.0 if dy == 0

      @slope = dy.fdiv(point2.x - point1.x)
    end

    def vertical?
      slope.infinite?
    end

    def horizontal?
      slope.zero?
    end

    def y_intercept
      return if vertical?
      point1.y - (point1.x * slope)
    end

    def x_intercept
      return if horizontal?
      point.x - (point1.y / slope)
    end

    def parallel_to?(other : Line)
      slope.infinite? && other.slope.infinite? || slope == other.slope
    end

    def intersect_x(other : Line)
      if vertical? && other.vertical?
        return x_intercept == other.x_intercept ? x_intercept : nil
      end
      
      return if horizontal? && other.horizontal?
      return x_intercept if vertical?
      return other.x_intercept if other.vertical?

      (other.y_intercept - y_intercept) / (slope - other.slope)
    end

    def angle_to(other : Line)
      (Math.atan(slope) - Math.atan(other.slope)).abs
    end

    def distance_to(other : Point)
      x0 = other.x
      y0 = other.y

      x1 = point1.x
      x2 = point2.x
      y1 = point1.y
      y2 = point2.y

      (((x2-x1) * (y1-y0)) - ((x1-x0) * (y2-y1))).abs / Math.sqrt((x2 - x1) ** 2 + (y2 - y1) **2)
    end

    def length
      point1.distance_to(point2)
    end
  end
end
