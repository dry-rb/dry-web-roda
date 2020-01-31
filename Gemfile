source "https://rubygems.org"

gemspec

eval_gemfile 'Gemfile.devtools'

group :tools do
  gem 'pry'
  gem 'byebug', platform: :ruby
end

group :development do
  gem "aruba"
  gem "bundler"
  gem "rake"
  gem "waitutil"
end

group :test do
  # Generated application dependencies
  gem "puma"
  gem "rack_csrf"
  gem "rerun"
  gem "rack", ">= 2.0"
  gem "pg"
  gem "rom", "~> 5.1"
  gem "rom-factory", "~> 0.10"
  gem "rom-sql", "~> 3.1"
  gem "dry-matcher"
  gem "dry-monads"
  gem "dry-struct"
  gem "dry-system"
  gem "dry-types"
  gem "dry-validation"
  gem "dry-view"
  gem "dry-web"
  gem "slim"
  gem "pry-byebug", platform: :ruby
  gem "capybara"
  gem "capybara-screenshot"
  gem "database_cleaner"
  gem "poltergeist"
  gem "rspec"
end
