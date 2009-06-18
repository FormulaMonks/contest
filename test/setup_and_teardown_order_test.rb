require File.dirname(__FILE__) + "/../lib/contest"

class BaseTest < Test::Unit::TestCase
  def setup
    @order = []
    @order << "Grandparent Setup"
  end

  def teardown
    @order << "Grandparent Teardown"

    assert_equal ["Grandparent Setup", "Parent Setup", "Child Setup", "Test Case", "Child Teardown", "Parent Teardown", "Grandparent Teardown"], @order
  end
end

class MidLayerTest < BaseTest
  setup { @order << "Parent Setup" }
  teardown { @order << "Parent Teardown" }
end

class LeafTest < MidLayerTest
  setup { @order << "Child Setup" }
  teardown { @order << "Child Teardown" }

  test "my actual test" do
    @order << "Test Case"
  end
end
