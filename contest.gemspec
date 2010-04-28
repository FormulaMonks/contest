Gem::Specification.new do |s|
  s.name        = 'contest'
  s.version     = '0.1.2'
  s.summary     = %{Write more readable tests in Test::Unit with this tiny script.}
  s.description = %{Write declarative tests using nested contexts without performance penalties. Contest is less than 100 lines of code and gets the job done.}
  s.authors     = ["Damian Janowski", "Michel Martens"]
  s.email       = ["djanowski@dimaion.com", "michel@soveran.com"]
  s.homepage  = "http://github.com/citrusbyte/contest"
  s.files = ["lib/contest.rb", "README.markdown", "LICENSE", "Rakefile", "rails/init.rb", "test/all_test.rb", "test/setup_and_teardown_order_test.rb"]
  s.rubyforge_project = "contest"
end

