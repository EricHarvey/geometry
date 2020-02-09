require "../spec_helper"

describe BoundingBox do
  describe "#contains?" do
    box = BoundingBox.new(Point.new(-1, -1), Point.new(1, 1))

    it "should return true if point is contained" do
      box.contains?(Point.new(0, 0)).should eq(true)
    end

    it "should return false if point is not contained" do
      box.contains?(Point.new(2, 2)).should eq(false)
      box.contains?(Point.new(-2, -2)).should eq(false)
      box.contains?(Point.new(1, 2)).should eq(false)
      box.contains?(Point.new(0, -2)).should eq(false)
    end

    it "should return true if point is on the edge of the box" do
      box.contains?(Point.new(1, 1)).should eq(true)
    end
  end
end
