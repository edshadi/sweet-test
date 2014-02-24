# it's better than Rspec, it's SweetTest :)

def describe description
  puts description
  yield
end

def it description, &block
  puts description
  block.call
end

def expect expectation=nil, &block
  SweetTest::Expectation.new expectation, &block
end

def let name, &block
  define_method name, &block
end

module SweetTest
  class Expectation
    def initialize actual, &block
      @actual = actual || block
    end

    def to
      @assert = true
      self
    end

    def to_not
      @assert = false
      self
    end

    def eq expected
      assert @actual, expected
    end

    def raise_error exception
      begin
        @actual.call
      rescue Exception => e
        assert e.class, exception
      end
    end

    def change &subject
      before = subject.call
      @actual.call
      assert before == subject.call, false
    end

    def be_true
      assert @actual, true
    end

    def be_false
      assert @actual, false
    end

    def assert actual, expected
      lets_assert = @assert ? actual == expected : actual != expected
      puts lets_assert || "false: expected #{expected}, got #{actual}"
    end

  end
end
