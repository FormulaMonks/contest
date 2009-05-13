Gem::Specification.new do |s|
  s.name = 'contest'
  s.version = '0.0.9'
  s.summary = %{Write more readable tests in Test::Unit with this tiny script.}
  s.date = %q{2009-03-16}
  s.authors = ["Damian Janowski", "Michel Martens"]
  s.email = "damian.janowski@gmail.com"
  s.homepage = "http://github.com/citrusbyte/contest"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/contest.rb", "README.markdown", "LICENSE", "Rakefile", "rails/init.rb", "test/all_test.rb", "test/setup_and_teardown_order.rb"]

  s.require_paths = ['lib']

  s.has_rdoc = false
end

