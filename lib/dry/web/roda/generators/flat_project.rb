require "securerandom"
require "dry/web/roda/generators/inflections"
require "dry/web/roda/generators/abstract_project"

module Dry
  module Web
    module Roda
      module Generators
        class FlatProject < AbstractProject
          def map_templates
            add_bin
            add_config
            add_db
            add_log
            add_specs
            add_lib
            add_system
            add_transactions
            add_web
            add_config_files
          end

          private

          def destination
            target_dir
          end

          def prepare_scope
            {
              underscored_app_name: underscored_app_name,
              camel_cased_app_name: Inflections.camel_cased_name(target_dir)
            }
          end
        end
      end
    end
  end
end
