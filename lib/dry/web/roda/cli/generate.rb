require "thor"

module Dry
  module Web
    module Roda
      class CLI
        class Generate < Thor
          desc "generate app APP", "Generate an app within a dry-web umbrella"
          option :umbrella, required: true, banner: "UMBRELLA_NAME", desc: "Provide the name of the umbrella app, e.g. my_project"
          def app(app_name)
            require "dry/web/roda/generators/app"
            Dry::Web::Roda::Generators::App.new.(app_name, umbrella: options[:umbrella])
          end
        end
      end
    end
  end
end
