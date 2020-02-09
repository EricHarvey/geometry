require "spec"
require "../src/geometry"

include Geometry

# Hacks to make focusing a spec more similar to rspec
def fit(description, &block)
  it(description, focus: true, &block)
end

def fcontext(description, &block)
  context(description, focus: true, &block)
end

def fdescribe(description, &block)
  describe(description, focus: true, &block)
end
