require "inflecto"
require "dry/web/roda/generate"

module Dry
  module Web
    module Roda
      module Generators
        class SubApp
          attr_reader :generate

          def initialize
            @generate = Dry::Web::Roda::Generate.new("sub_app")
          end

          def call(target_dir, options = {})
            umbrella_name = options.fetch(:umbrella)
            generate_to = options.fetch(:to) { File.join("apps", target_dir) }

            generate.(generate_to, prepare_scope(target_dir, umbrella_name))
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
