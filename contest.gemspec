Gem::Specification.new do |s|
  s.name = 'contest'
  s.version = '0.0.1'
  s.summary = %{Contexts for Test::Unit}
  s.date = %q{2009-03-16}
  s.author = "Damian Janowski"
  s.email = "damian.janowski@gmail.com"
  s.homepage = "http://github.com/citrusbyte/contest"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/contest.rb", "README.markdown", "LICENSE", "Rakefile", "test/all_test.rb"]

  s.require_paths = ['lib']

  s.has_rdoc = false
end

