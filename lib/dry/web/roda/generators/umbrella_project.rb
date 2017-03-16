require "securerandom"
require "dry/web/roda/generators/inflections"
require "dry/web/roda/generators/flat_project"
require "dry/web/roda/generators/sub_app"

module Dry
  module Web
    module Roda
      module Generators
        class UmbrellaProject < FlatProject

          def post_process_callback
            Dir.chdir(target_dir) do
              Generators::SubApp.new("main", umbrella: target_dir).call
            end
          end
          
        end
      end
    end
  end
end
