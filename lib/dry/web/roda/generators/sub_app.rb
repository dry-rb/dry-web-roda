require "dry/web/roda/generate"
require "dry/web/roda/generators/inflections"

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
              underscored_app_name: Inflections.underscored_name(target_dir),
              camel_cased_app_name: Inflections.camel_cased_name(target_dir),
              underscored_umbrella_name: Inflections.underscored_name(umbrella_name),
              camel_cased_umbrella_name: Inflections.camel_cased_name(umbrella_name),
            }
          end
        end
      end
    end
  end
end
