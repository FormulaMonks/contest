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
    define_method :setup do
      super(&block)
      instance_eval(&block)
    end
  end

  def self.teardown(&block)
    define_method :teardown do
      instance_eval(&block)
      super(&block)
    end
  end

  def self.context(*name, &block)
    subclass = Class.new(self)
    @context_subclasses ||= []
    @context_subclasses << subclass
    remove_tests(subclass)
    subclass.class_eval(&block) if block_given?
    const_set(context_name(name.join(" ")), subclass)
  end

  def self.test(name, &block)
    method_name = test_name(name)
    # When adding new methods to a context's parent context, avoiding adding them to any context
    # subclasses via inheritance. Note that a subcontext can have its own test called "name"; don't
    # undefine it.
    contexts_without_matching_test_name = (@context_subclasses || []).reject do |context|
      context.instance_methods.include?(method_name.to_s)
    end

    define_method(method_name, &block)
    contexts_without_matching_test_name.each { |subclass| subclass.send(:undef_method, method_name) }
  end

  class << self
    alias_method :should, :test
    alias_method :describe, :context
  end

private

  def self.context_name(name)
    "Test#{sanitize_name(name).gsub(/(^| )(\w)/) { $2.upcase }}".to_sym
  end

  def self.test_name(name)
    "test_#{sanitize_name(name).gsub(/\s+/,'_')}".to_sym
  end

  def self.sanitize_name(name)
    name.gsub(/\W+/, ' ').strip
  end

  def self.remove_tests(subclass)
    subclass.public_instance_methods.grep(/^test_/).each do |meth|
      subclass.send(:undef_method, meth.to_sym)
    end
  end
end
