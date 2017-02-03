source "https://rubygems.org"

# Specify your gem's dependencies in rodakase.gemspec
gemspec

group :test do
  gem 'byebug', platform: :mri
  gem 'rack', '>= 2.0.0'
  gem 'rack-test'
  gem 'dry-monads'
  gem 'dry-transaction'
  gem 'dry-view'
  gem 'slim'

  gem 'codeclimate-test-reporter', platform: :rbx
end

group :tools do
  gem 'pry'
end


gem 'puma',      require: false
gem 'rack_csrf', require: false
gem 'shotgun',   '~> 0.9',    require: false
gem 'pg',        require: false
gem "rom-repository", require: false
gem "rom-sql",        require: false
gem 'dry-validation', require: false
gem 'pry-byebug',     require: false
gem 'capybara',       require: false
gem 'capybara-screenshot', require: false
gem 'database_cleaner',    require: false
gem 'poltergeist',         require: false
