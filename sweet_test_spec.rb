require_relative 'sweet_test'
class Awesome
  attr_accessor :ness
  def initialize
    @ness = 0
  end
  def hello name
    name
  end
  def ness_up
    self.ness += 1
  end
end

describe Awesome do
  let(:awesome) { Awesome.new }
  describe "#ness" do
    it "is inititalized with zero" do
      expect(awesome.ness).to.eq(0)
      expect(awesome.ness).to_not.eq(3)
    end
  end

  describe "#hello" do
    it "it raises an Argument error if no name is given" do
      expect { awesome.hello }.to.raise_error(ArgumentError)
    end
  end

  describe "#ness_up" do
    it "increments the ness" do
      # pop quiz: why do we have to do line 33? remember our library is not as sofisticated as Rspec, so the let doesn't really run before each it, it just defines a method...this one is tricky, come talk to me about it :)
      a = awesome
      expect { a.ness_up }.to.change { a.ness }
    end
  end
end
