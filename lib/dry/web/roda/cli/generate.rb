require "thor"

module Dry
  module Web
    module Roda
      class CLI
        class Generate < Thor
          desc "generate sub_app APP", "Generate a sub-app within a dry-web umbrella app"
          option :umbrella, required: true, banner: "UMBRELLA_NAME", desc: "Provide the name of the umbrella app, e.g. my_project"
          def sub_app(app_name)
            require "dry/web/roda/generators/sub_app"
            Dry::Web::Roda::Generators::SubApp.new(app_name, umbrella: options[:umbrella]).call
          end
        end
      end
    end
  end
end
