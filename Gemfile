source "https://rubygems.org"

# Specify your gem's dependencies in rodakase.gemspec
gemspec

group :test do
  gem 'byebug', platform: :mri
  gem 'rack', '>= 1.0.0', '<= 2.0.0'
  gem 'rack-test'
  gem 'dry-monads'
  gem 'dry-transaction'
  gem 'dry-view'
  gem 'dry-web', '~> 0.4.0'
  gem 'slim'

  gem 'codeclimate-test-reporter', platform: :rbx
end

group :tools do
  gem 'pry'
end
