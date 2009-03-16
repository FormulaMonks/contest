require "test/unit"

class Test::Unit::TestCase
  def default_test; end

  def self.setup(&block)
    setup_blocks << block
  end

  def setup
    self.class.setup_blocks.each do |block|
      instance_eval(&block)
    end
  end

  def self.context(name, &block)
    subclass = Class.new(self.superclass)
    subclass.setup_blocks.unshift(*setup_blocks)
    subclass.class_eval(&block)
    const_set(context_name(name), subclass)
  end

  def self.test(name, &block)
    define_method(test_name(name), &block)
  end

private

  def self.setup_blocks
    @setup_blocks ||= []
  end

  def self.context_name(name)
    "#{name.gsub(/(^| )(\w)/) { $2.upcase }}Test".to_sym
  end

  def self.test_name(name)
    "test_#{name.gsub(/\s+/,'_')}".to_sym
  end
end
