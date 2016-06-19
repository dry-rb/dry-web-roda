require "thor"

module Dry
  module Web
    module Roda
      class CLI < Thor
        desc "new APP", "Generate a new dry-web-roda project"
        def new(app_name)
          require "dry/web/roda/generators/umbrella"
          Dry::Web::Roda::Generators::Umbrella.new.call(app_name)
        end
      end
    end
  end
end
