require_relative "db_spec_helper"

require "rack/test"
require "capybara/rspec"
require "capybara-screenshot/rspec"
require "capybara/poltergeist"

Dir[SPEC_ROOT.join("support/web/*.rb").to_s].each(&method(:require))
Dir[SPEC_ROOT.join("shared/web/*.rb").to_s].each(&method(:require))

require SPEC_ROOT.join("../system/boot").realpath

Capybara.app = Test::WebHelpers.app
Capybara.server_port = 3001
Capybara.save_path = "#{File.dirname(__FILE__)}/../tmp/capybara-screenshot"
Capybara.javascript_driver = :poltergeist
Capybara::Screenshot.prune_strategy = {keep: 10}

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors: false,
    phantomjs_logger: File.open(SPEC_ROOT.join("../log/phantomjs.log"), "w"),
    phantomjs_options: %w(--load-images=no),
    window_size: [1600, 768],
  )
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include Rack::Test::Methods, Capybara::DSL, type: :feature
  config.include Test::WebHelpers

  config.before :suite do
    Test::WebHelpers.app.freeze
  end
end
