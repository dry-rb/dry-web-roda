source "https://rubygems.org"

# Specify your gem's dependencies in rodakase.gemspec
gemspec

group :test do
  gem 'byebug', platform: :mri
  gem 'rack-test'
  gem 'dry-monads'
  gem 'dry-view'
  gem 'dry-web', github: 'dry-rb/dry-web', branch: 'extract-roda'
  gem 'slim'

  gem 'codeclimate-test-reporter', platform: :rbx
end

group :tools do
  gem 'pry'
end
