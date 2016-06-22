require "inflecto"
require "securerandom"
require "dry/web/roda/generate"
require "dry/web/roda/generators/app"

module Dry
  module Web
    module Roda
      module Generators
        class Umbrella
          attr_reader :generate, :app_generator

          def initialize
            @generate = Generate.new("umbrella")
            @app_generator = Generators::App.new
          end

          def call(target_dir)
            generate.(target_dir, prepare_scope(target_dir))

            Dir.chdir(target_dir) do
              app_generator.("main", target_dir)
            end
          end

          private

          def prepare_scope(target_dir)
            {
              underscored_app_name: Inflecto.underscore(target_dir),
              camel_cased_app_name: Inflecto.camelize(target_dir)
            }
          end
        end
      end
    end
  end
end
