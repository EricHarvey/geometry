module Geometry
  struct Segment
    property :point1, :point2

    def initialize(@point1 : Point, @point2 : Point)
    end

    def leftmost_endpoint
      ((point1.x <=> point2.x) == -1) ? point1 : point2
    end

    def rightmost_endpoint
      ((point1.x <=> point2.x) == 1) ? point1 : point2
    end

    def topmost_endpoint
      ((point1.y <=> point2.y) == 1) ? point1 : point2
    end

    def bottommost_endpoint
      ((point1.y <=> point2.y) == -1) ? point1 : point2
    end

    def contains_point?(point : Point)
      distance(point1, point2) == distance(point1, point) + distance(point, point2)
    end

    def parallel_to?(other : Segment)
      to_vector.collinear_with?(other.to_vector)
    end

    def lies_on_one_line_with?(other : Segment)
      Segment.new(point1, other.point1).parallel_to?(self) && Segment.new(point1, other.point2).parallel_to?(self)
    end

    def intersects_with?(other : Segment)
      Segment.have_intersecting_bounds?(self, other) &&
        lies_on_line_intersecting?(other) && other.lies_on_line_intersecting?(self)
    end

    def overlaps?(other : Segment)
      Segment.have_intersecting_bounds?(self, other) && lies_on_one_line_with?(other)
    end

    def intersection_point_with(other : Segment)
      return nil if !intersects_with?(other) || overlaps?(other)

      numerator = (other.point1.y - point1.y) * (other.point1.x - other.point2.x) -
                  (other.point1.y - other.point2.y) * (other.point1.x - point1.x)
      denominator = (point2.y - point1.y) *
                    (other.point1.x - other.point2.x) -
                    (other.point1.y - other.point2.y) *
                    (point2.x - point1.x)

      t = numerator.fdiv(denominator)

      x = point1.x + t * (point2.x - point1.x)
      y = point1.y + t * (point2.y - point1.y)

      Point.new(x, y)
    end

    def distance_to(point : Point)
      return distance(point, point1) if point1 == point2

      q = point.to_vector
      p1 = point1.to_vector
      p2 = point2.to_vector

      u = p2 - p1
      v = q - p1

      a = u.scalar_product(v)
      return distance(q, p1) if a < 0

      b = u.scalar_product(u)
      p = a > b ? p2 : (p1 + a.fdiv(b * u))

      distance(q, p)
    end

    def length
      distance(point1, point2)
    end

    def to_vector
      Vector.new(point2.x - point1.x, point2.y - point1.y)
    end

    private def self.have_intersecting_bounds?(segment1 : Segment, segment2 : Segment)
      intersects_on_x_axis =
        (segment1.leftmost_endpoint.x < segment2.rightmost_endpoint.x ||
          segment1.leftmost_endpoint.x == segment2.rightmost_endpoint.x) &&
          (segment2.leftmost_endpoint.x < segment1.rightmost_endpoint.x ||
            segment2.leftmost_endpoint.x == segment1.rightmost_endpoint.x)

      intersects_on_y_axis =
        (segment1.bottommost_endpoint.y < segment2.topmost_endpoint.y ||
          segment1.bottommost_endpoint.y == segment2.topmost_endpoint.y) &&
          (segment2.bottommost_endpoint.y < segment1.topmost_endpoint.y ||
            segment2.bottommost_endpoint.y == segment1.topmost_endpoint.y)

      intersects_on_x_axis && intersects_on_y_axis
    end

    private def lies_on_line_intersecting?(segment : Segment)
      vector_to_first_endpoint = Segment.new(self.point1, segment.point1).to_vector
      vector_to_second_endpoint = Segment.new(self.point1, segment.point2).to_vector

      self.to_vector.cross_product(vector_to_first_endpoint) *
        self.to_vector.cross_product(vector_to_second_endpoint) <= 0
    end
  end
end
