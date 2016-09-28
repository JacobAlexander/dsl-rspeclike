def describe(description, &block)
  ExampleGroup.new(block).evaluate
end

class ExampleGroup

  def initialize(block)
    @block = block
  end

  def evaluate
    # we are using instance_eval because otherwise we are working in describe method context, where program don't know about it method
    # by usind self.instance eval, we are executing provided block code inside ExampleGroup class, that mean, program knows about it method
    self.instance_eval(&@block)
  end

  def it(description, &block)
    block.call
  end

  def expect(obj)
    ObjectWithExpectation.new(obj)
  end

  def eq(val)
  end

end

class ObjectWithExpectation

  def initialize(object)
    @object = object
  end

  def to(*)
  end

  def not_to(*)
  end

end


describe "Amazing RSpeclike example" do
  it "works!" do
    expect(2+2).to eq(4)
  end
end