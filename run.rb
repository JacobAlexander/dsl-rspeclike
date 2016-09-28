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

end


describe "Amazing RSpeclike example" do
  it "works!" do
    puts "hello"
  end
end