module Geometry
  struct PointInPolygon
    property :point, :polygon
    delegate vertices, edges, bounding_box, to: @polygon

    def initialize(@point : Point, @polygon : Polygon)
    end

    def inside?
      point_location == :inside
    end

    def outside?
      point_location == :outside
    end

    def on_the_boundary?
      point_location == :on_the_boundary
    end

    def point_location
      return :outside unless bounding_box.contains?(point)
      return :on_the_boundary if point_is_vertex? || point_on_edge?

      intersection_count(choose_good_ray).odd? ? :inside : :outside
    end

    private def point_is_vertex?
      vertices.any?(&.==(point))
    end

    private def point_on_edge?
      edges.any?(&.contains_point?(point))
    end

    def choose_good_ray
      ray = random_ray
      until good_ray?(ray)
        ray = random_ray
      end
      ray
    end

    private def good_ray?(ray : Segment)
      edges.none? { |edge| !edge.length.zero? && edge.parallel_to?(ray) } &&
        vertices.none? { |vertex| ray.contains_point?(vertex) }
    end

    private def intersection_count(ray : Segment)
      edges.count(&.intersects_with?(ray))
    end

    private def random_ray
      random_direction = rand * (2 * Math.PI)

      ray_endpoint = Point.new(sufficient_ray_radius * Math.cos(random_direction),
        sufficient_ray_radius * Math.sin(random_direction))
      Segment.new(point, ray_endpoint)
    end

    private def sufficient_ray_radius
      @sufficient_ray_radius ||= bounding_box.diagonal.length * 2
    end
  end
end
