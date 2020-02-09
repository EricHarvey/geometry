require "../spec_helper"

describe Point do
  it "should initialize with the correct values" do
    point = Point.new(1, 2)

    point.x.should eq(1)
    point.y.should eq(2)
  end

  it "should initialize with the correct values by array" do
    point = Point.new_by_array([1, 2])

    point.x.should eq(1)
    point.y.should eq(2)
  end

  it "returns true if points are equal" do
    Point.new(1, 3).should eq(Point.new(1, 3))
  end

  it "returns false if points are not equal" do
    Point.new(1, 3).should_not eq(Point.new(2, 3))
  end

  it "returns the correct distance" do
    Point.new(0, 0).distance_to(Point.new(3, 4)).should eq(5)
    Point.new(3, 0).distance_to(Point.new(0, 4)).should eq(5)
    Point.new(0, 4).distance_to(Point.new(3, 0)).should eq(5)
    Point.new(3, 4).distance_to(Point.new(0, 0)).should eq(5)
    Point.new(0, 0).distance_to(Point.new(1, 1)).should eq(sqrt(2))
  end

  it "should advance by the correct amount" do
    Point.new(5, 5).should eq(Point.new(10, 15).advance_by(Vector.new(-5, -10)))
  end
end
