require_relative "db_helper"

require "rack/test"
require "capybara/rspec"
require "capybara-screenshot/rspec"
require "capybara/poltergeist"

Dir[SPEC_ROOT.join("support/app/*.rb").to_s].each(&method(:require))
Dir[SPEC_ROOT.join("shared/app/*.rb").to_s].each(&method(:require))

require SPEC_ROOT.join("../system/boot").realpath

Capybara.app = TestHelpers.app
Capybara.server_port = 3001
Capybara.save_and_open_page_path = "#{File.dirname(__FILE__)}/../tmp/capybara-screenshot"
Capybara.javascript_driver = :poltergeist
Capybara::Screenshot.prune_strategy = {keep: 10}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors: false,
    phantomjs_logger: File.open(SPEC_ROOT.join("../logs/phantomjs.log"), "w"),
    phantomjs_options: %w(--load-images=no)
  )
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include Rack::Test::Methods, Capybara::DSL, type: :feature

  config.before :suite do
    TestHelpers.app.freeze
  end
end
