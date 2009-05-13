require File.dirname(__FILE__) + "/../lib/contest"

class Test::Unit::TestCase
  setup { puts "Grandparent Setup" }
end

class Test::Unit::TestCase
  teardown { puts "Grandparent Teardown" }
end

class MidLayerTest < Test::Unit::TestCase
  setup { puts "Parent Setup" }
  teardown { puts "Parent Teardown" }
end

class LeafTest < MidLayerTest
  setup { puts "Child Setup" }
  teardown { puts "Child Teardown" }

  test "my actual test" do
    puts "Test Case"
  end
end
