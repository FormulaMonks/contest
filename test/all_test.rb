require File.dirname(__FILE__) + "/../lib/contest"

class FooTest < Test::Unit::TestCase
  setup do
    @value = 1
  end

  teardown do
    @value = nil
  end

  test "truth" do
    assert_equal 1, @value
  end

  context "context's non-word characters " do
    should "run the test inside" do
      assert_equal 1, @value
    end
  end

  context "some context" do
    setup do
      @value += 1
    end

    test "another truth" do
      assert_equal 2, @value
    end

    context "and a nested context" do
      setup do
        @value += 1
      end

      test "more" do
        assert_equal 3, @value
      end
    end
  end

  context "some other context" do
    setup do
      @value += 1
    end

    test "yet another truth" do
      assert_equal 2, @value
    end
  end

  describe "context with should" do
    setup do
      @value += 1
    end

    should "yet another truth" do
      assert_equal 2, @value
    end
  end
end

class BarTest < Test::Unit::TestCase
  setup do
    @value = 1
  end

  context "some context" do
    setup do
      @value += 1
    end

    test "another truth" do
      assert_equal 2, @value
    end

    test "another truth" do
      assert_equal 2, @value
    end
  end
end

class TestBaz < Test::Unit::TestCase
  def foo
    42
  end

  def setup
    @value = 1
    super
  end

  context "some context" do
    def setup
      super
      @value += 2
    end

    def bar
      foo + 1
    end

    test "a helper" do
      assert_equal 42, foo
      assert_equal 3, @value
    end

    test "another helper" do
      assert_equal 43, bar
    end

    context "another context" do
      setup do
        @value += 3
      end

      test "blah" do
        assert_equal 6, @value
      end
    end
  end

  context "empty context"
end
