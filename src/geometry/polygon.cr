module Geometry
  struct Polygon
    property :vertices

    def initialize(@vertices : Array(Point))
    end

    def edges
      edges = [] of Segment
      vertices.each_cons(2) do |points|
        edges << Segment.new(points.first, points[1])
      end
      edges << Segment.new(points.last, points.first)
    end

    def bounding_box
      BoundingBox.new(Point.new(vertices.min_by(&.x), vertices.min_by(&.y),
        Point.new(vertices.max_by(&.x), vertices.max_by(&.y))))
    end

    def contains?(point : Point)
      pip = PointInPolygon.new(point, self)
      pip.inside? || pip.on_the_boundary?
    end

    def area
      sum = (0..vertices.size - 1).reduce(0.0) do |curr, idx|
        a = vertices[idx - 1]
        b = vertices[idx]
        curr + ((a.x * b.y) - (a.y * b.x))
      end

      (sum / 2).abs
    end
  end
end
