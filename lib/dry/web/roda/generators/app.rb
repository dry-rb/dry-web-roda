require "inflecto"
require "dry/web/roda/generate"

module Dry
  module Web
    module Roda
      module Generators
        class App
          attr_reader :generate

          def initialize
            @generate = Dry::Web::Roda::Generate.new("app")
          end

          def call(target_dir, umbrella_name)
            generate.call(File.join("apps", target_dir), prepare_scope(target_dir, umbrella_name))
          end

          private

          def prepare_scope(target_dir, umbrella_name)
            {
              underscored_app_name: Inflecto.underscore(target_dir),
              camel_cased_app_name: Inflecto.camelize(target_dir),
              underscored_umbrella_name: Inflecto.underscore(umbrella_name),
              camel_cased_umbrella_name: Inflecto.camelize(umbrella_name),
            }
          end
        end
      end
    end
  end
end
