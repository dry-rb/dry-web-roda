require 'dry/web/roda/application'
require_relative 'container'

module Main
  class Application < Dry::Web::Roda::Application
    configure do |config|
      config.routes = 'web/routes'.freeze
      config.container = Main::Container
    end

    route do |r|
      r.multi_route
    end

    load_routes!
  end
end
