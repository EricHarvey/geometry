require "math"
require "./geometry/*"

# TODO: Write documentation for `Geometry`
module Geometry
  VERSION = "0.1.0"

  # TODO: Put your code here
  include Math
  extend Math

  def distance(point1 : Point, point2 : Point)
    hypot(point1.x - point2.x, point1.y - point2.y)
  end
end
