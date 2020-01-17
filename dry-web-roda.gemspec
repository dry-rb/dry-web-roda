# frozen_string_literal: true
# this file is managed by dry-rb/devtools project

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dry/web/roda/version'

Gem::Specification.new do |spec|
  spec.name          = 'dry-web-roda'
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.license       = 'MIT'
  spec.version       = Dry::Web::Roda::VERSION.dup

  spec.summary       = "Roda integration for dry-web apps"
  spec.description   = spec.summary
  spec.homepage      = 'https://dry-rb.org/gems/dry-web-roda'
  spec.files         = Dir['CHANGELOG.md', 'LICENSE', 'README.md', 'dry-web-roda.gemspec', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['changelog_uri']     = 'https://github.com/dry-rb/dry-web-roda/blob/master/CHANGELOG.md'
  spec.metadata['source_code_uri']   = 'https://github.com/dry-rb/dry-web-roda'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/dry-rb/dry-web-roda/issues'

  spec.required_ruby_version = '>= 2.4.0'

  # to update dependencies edit project.yml
  spec.add_runtime_dependency "dry-configurable", "~> 0.2"
  spec.add_runtime_dependency "dry-inflector", "~> 0.2"
  spec.add_runtime_dependency "roda", "~> 3.0"
  spec.add_runtime_dependency "roda-flow", "~> 0.4"
  spec.add_runtime_dependency "thor", "~> 0.19"

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "capybara", "~> 2.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "waituntil"
end
