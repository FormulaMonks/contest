# ActiveStupor defines its own idiom for the class-level setup method
# (using callback chains). This hack is to ensure that Contest users can
# still call the setup method with a block.
if RAILS_ENV == 'test'
  require File.join(File.dirname(__FILE__), '..', 'lib', 'contest')
  require "active_support/test_case"
  
  class Test::Unit::TestCase
    class << self
      alias contest_setup setup
    end
  end
  
  class ActiveSupport::TestCase
    class << self
      alias activesupport_setup setup
    end
  
    def self.setup(*args, &block)
      if args.empty?
        contest_setup(&block)
      else
        activesupport_setup(*args)
      end
    end
  end
end
