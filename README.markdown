Contest
=======

Contexts for Test::Unit.

Description
-----------

Write declarative tests using nested contexts without performance penalties. Contest is less than 100 lines of code and gets the job done.

Usage
-----

Declare your tests as you would in RSpec or Shoulda:

    require 'contest'

    class SomeTest < Test::Unit::TestCase
      setup do
        @value = 1
      end

      teardown do
        @value = nil
      end

      test "sample test" do
        assert_equal 1, @value
      end

      context "a context" do
        setup do
          @value += 1
        end

        test "more tests" do
          assert_equal 2, @value
        end

        context "a nested context" do
          setup do
            @value += 1
          end

          test "yet more tests" do
            assert_equal 3, @value
          end
        end
      end
    end

For your convenience, `context` is aliased as `describe` and `test` is aliased as `should`, so this is valid:

    class SomeTest < Test::Unit::TestCase
      setup do
        @value = 1
      end

      describe "something" do
        setup do
          @value += 1
        end

        should "equal 2" do
          assert_equal 2, @value
        end
      end
    end

You can run it normally, it's Test::Unit after all. If you want to run a particular test, say "yet more tests", try this:

    $ testrb my_test.rb -n test_yet_more_tests

Or with a regular expression:

    $ testrb my_test.rb -n /yet_more_tests/

Installation
------------

    $ sudo gem install contest

If you want to use it with Rails, add this to config/environment.rb:

    config.gem "contest"

Then you can vendor the gem:

    rake gems:install
    rake gems:unpack

License
-------

Copyright (c) 2009 Damian Janowski and Michel Martens for Citrusbyte

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
