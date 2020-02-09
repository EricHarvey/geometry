require "./spec_helper"

describe Geometry do
  it "should return the correct distance" do
    distance(Point.new(1, 1), Point.new(1, 2)).should eq(1)
    distance(Point.new(1, 1), Point.new(2, 1)).should eq(1)
    distance(Point.new(1, 1), Point.new(2, 2)).should eq(sqrt(2))
  end
end
