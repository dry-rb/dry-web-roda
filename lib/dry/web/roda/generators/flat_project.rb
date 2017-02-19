require "securerandom"
require "dry/web/roda/generate"
require "dry/web/roda/generators/inflections"

module Dry
  module Web
    module Roda
      module Generators
        class FlatProject
          attr_reader :generate

          def initialize
            @generate = Generate.new("flat_project")
          end

          def call(target_dir)
            generate.(target_dir, prepare_scope(target_dir))
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
