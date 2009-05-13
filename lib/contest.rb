require "test/unit"

# Test::Unit loads a default test if the suite is empty, whose purpose is to
# fail. Since having empty contexts is a common practice, we decided to
# overwrite TestSuite#empty? in order to allow them. Having a failure when no
# tests have been defined seems counter-intuitive.
class Test::Unit::TestSuite
  def empty?
    false
  end
end

# Contest adds +teardown+, +test+ and +context+ as class methods, and the
# instance methods +setup+ and +teardown+ now iterate on the corresponding
# blocks. Note that all setup and teardown blocks must be defined with the
# block syntax. Adding setup or teardown instance methods defeats the purpose
# of this library.
class Test::Unit::TestCase
  def self.setup(&block)
    setup_blocks << block
  end

  def self.teardown(&block)
    teardown_blocks << block
  end

  def setup
    eval_blocks(:setup_blocks, self.class.ancestors.reverse)
  end

  def teardown
    eval_blocks(:teardown_blocks, self.class.ancestors)
  end

  def self.context(name, &block)
    subclass = Class.new(self.superclass)
    subclass.setup_blocks.unshift(*setup_blocks)
    subclass.teardown_blocks.unshift(*teardown_blocks)
    subclass.class_eval(&block)
    const_set(context_name(name), subclass)
  end

  def self.test(name, &block)
    define_method(test_name(name), &block)
  end

  class << self
    alias_method :should, :test
    alias_method :describe, :context
  end

private

  def eval_blocks(type, ancestors)
    ancestors.each do |ancestor|
      next unless ancestor.respond_to?(type)
      ancestor.send(type).each do |block|
        instance_eval(&block)
      end
    end
  end

  def self.setup_blocks
    @setup_blocks ||= []
  end

  def self.teardown_blocks
    @teardown_blocks ||= []
  end

  def self.context_name(name)
    "Test#{sanitize_name(name).gsub(/(^| )(\w)/) { $2.upcase }}".to_sym
  end

  def self.test_name(name)
    "test_#{sanitize_name(name).gsub(/\s+/,'_')}".to_sym
  end

  def self.sanitize_name(name)
    name.gsub(/\W+/, ' ').strip
  end
end
