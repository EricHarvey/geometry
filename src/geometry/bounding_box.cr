module Geometry
  struct BoundingBox
    property :left_bottom, :right_top

    def initialize(@left_bottom : Point, @right_top : Point)
    end

    def diagonal
      Segment.new(left_bottom, right_top)
    end

    def contains?(point : Point)
      (left_bottom.x..right_top.x).covers?(point.x) && (left_bottom.y..right_top.y).covers?(point.y)
    end
  end
end
