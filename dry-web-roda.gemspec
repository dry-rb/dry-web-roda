lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry/web/roda/version"

Gem::Specification.new do |spec|
  spec.name          = "dry-web-roda"
  spec.version       = Dry::Web::Roda::VERSION
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.summary       = "Roda integration for dry-web apps"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/dry-rb/dry-web-roda"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.3.0'

  spec.add_runtime_dependency "dry-configurable", "~> 0.2"
  spec.add_runtime_dependency "inflecto", "~> 0.0"
  spec.add_runtime_dependency "roda", "~> 2.14"
  spec.add_runtime_dependency "roda-flow", "~> 0.3"
  spec.add_runtime_dependency "thor", "~> 0.19"

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "capybara", "~> 2.5"
  spec.add_development_dependency "waitutil"
end
