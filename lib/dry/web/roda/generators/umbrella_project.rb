require "securerandom"
require "dry/web/roda/generate"
require "dry/web/roda/generators/inflections"
require "dry/web/roda/generators/sub_app"

module Dry
  module Web
    module Roda
      module Generators
        class UmbrellaProject
          attr_reader :generate, :sub_app_generator

          def initialize
            @generate = Generate.new("umbrella_project")
            @sub_app_generator = Generators::SubApp.new
          end

          def call(target_dir)
            generate.(target_dir, prepare_scope(target_dir))

            Dir.chdir(target_dir) do
              sub_app_generator.("main", umbrella: target_dir)
            end
          end

          private

          def prepare_scope(target_dir)
            {
              underscored_app_name: Inflections.underscored_name(target_dir),
              camel_cased_app_name: Inflections.camel_cased_name(target_dir)
            }
          end
        end
      end
    end
  end
end
