require "roda"
require "roda/plugins/flow"
require "dry-configurable"

module Dry
  module Web
    module Roda
      class Application < ::Roda
        extend Dry::Configurable

        setting :container, reader: true
        setting :routes

        plugin :multi_route
        plugin :flow
        plugin :error_handler

        def self.configure(&block)
          super.tap do
            use(container[:rack_monitor]) if container.config.listeners
          end
        end

        def self.resolve(name)
          container[name]
        end

        def self.[](name)
          container[name]
        end

        def self.load_routes!
          Dir[root.join("#{config.routes}/**/*.rb")].each { |f| require f }
        end

        def self.root
          container.config.root
        end

        def notifications
          self.class[:notifications]
        end
      end
    end
  end
end
