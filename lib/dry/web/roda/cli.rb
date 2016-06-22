require "thor"

module Dry
  module Web
    module Roda
      class CLI < Thor
        desc "new APP", "Generate a new dry-web-roda project"
        def new(app_name)
          require "dry/web/roda/generators/umbrella"
          Generators::Umbrella.new.(app_name)
        end

        desc "generate GENERATOR", "Generate a new component for an existing dry-web-roda project"
        require "dry/web/roda/cli/generate"
        subcommand "generate", CLI::Generate
      end
    end
  end
end
