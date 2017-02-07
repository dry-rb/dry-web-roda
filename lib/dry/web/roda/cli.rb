require "thor"

module Dry
  module Web
    module Roda
      class CLI < Thor
        desc "new APP", "Generate a new dry-web-roda project"
        option :arch, required: false, default: "umbrella", enum: %w[umbrella flat], banner: "ARCH", desc: "Project architecture (umbrella/flat)"
        def new(app_name)
          case options[:arch]
          when "umbrella"
            require "dry/web/roda/generators/umbrella_project"
            Generators::UmbrellaProject.new.(app_name)
          when "flat"
            require "dry/web/roda/generators/flat_project"
            Generators::FlatProject.new.(app_name)
          end
        end

        desc "generate GENERATOR", "Generate a new component for an existing dry-web-roda project"
        require "dry/web/roda/cli/generate"
        subcommand "generate", CLI::Generate
      end
    end
  end
end
