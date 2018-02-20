source "https://rubygems.org"

gem "rake"

# Web framework
gem "dry-system", "~> 0.9"
gem "dry-web", "~> 0.7"
gem "dry-web-roda", "~> 0.11"
gem "puma"
gem "rack_csrf"

gem "rack", ">= 2.0"
gem "rerun"

# Database persistence
gem "pg"
gem "rom", "~> 4.0"
gem "rom-sql", "~> 2.1"

# Application dependencies
gem "dry-matcher", "~> 0.6.0"
gem "dry-monads", "~> 0.3"
gem "dry-struct", "~> 0.3"
gem "dry-transaction", "~> 0.10"
gem "dry-types", "~> 0.12"
gem "dry-validation", "~> 0.11"
gem "dry-view", "~> 0.4"
gem "slim"

group :development, :test do
  gem "pry-byebug", platform: :mri
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "database_cleaner"
  gem "poltergeist"
  gem "rspec"
  gem "rom-factory", "~> 0.5"
end
