require File.expand_path("lib/simple_rewriter/version", __dir__)

Gem::Specification.new do |gem|
  gem.authors = ["Adam Grzybowski", "Piotr Misiurek", "Michał Szymański"]
  gem.email = ["adam@ragnarson.com", "piotr@ragnarson.com", "michal.t.szymanski@gmail.com"]
  gem.description = "Simple rewriter for rails based apps"
  gem.summary = "Simple rewriter for rails based apps"
  gem.license = "MIT"
  gem.homepage = "https://github.com/Verivox/simple_rewriter"

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "simple_rewriter"
  gem.require_paths = ["lib"]
  gem.version       = SimpleRewriter::VERSION

  gem.add_runtime_dependency("faker", "~> 1.9.3")

  gem.add_development_dependency("pry", "~> 0.12.2")
  gem.add_development_dependency("ragnarson-stylecheck", "~> 0.7.0")
  gem.add_development_dependency("rake", "~> 13.0.1")
  gem.add_development_dependency("rspec", "~> 3.8.0")
end
