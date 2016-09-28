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
    # Why it's so difficult ?
    # Proc objects are blocks of code that have been bound to a set of local variables.
    # Once bound, the code may be called in different contexts and still access those variables.
    #
    # So everything because of that different context !

    # obj is an initialized value from "call" in "to" method, and we are expecting that value by this syntax
    -> (obj) { obj == val }
    # Ps. it's not a shortcode of regular proc function!
    # Okay, it's proc because it know about local variables in his context
    # but it expecting too that declared variables like lambda!
    # So that's more like a mix of proc and lambda object - super object-function ? : )
  end

  def include(val)
    -> (obj) { obj.include? val }
  end

end

class ObjectWithExpectation

  def initialize(object)
    @object = object
  end

  def to(func)
    # Here we are calling expected "method with was proc function -> eq(4)" inside our method "to"
    # While calling method eq we send there our @object
    # So one more time:
    # We are saying hey eq! I know you are a proc function, so now do your job and take this @object as a initialized value

    if func.call(@object)
      print "."
    else
      print "F"
    end
  end

  def not_to(func)
    if !func.call(@object)
      print "."
    else
      print "F"
    end
  end

end


describe "Amazing RSpeclike example" do
  it "works!" do
    expect(2+2).to eq(4)
    expect(["a","b","c","d"]).to include("bb")
  end
end
