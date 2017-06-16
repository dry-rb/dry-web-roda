require "securerandom"
require "dry/web/roda/generators/abstract_project"

module Dry
  module Web
    module Roda
      module Generators
        class FlatProject < AbstractProject
          def populate_templates
            super
            add_views
            add_web
          end

          private

          def add_boot
            add_template("flat_project/boot.rb.tt", "system/boot.rb")
          end

          def add_application
            add_template("flat_project/application.rb.tt", "system/#{underscored_project_name}/application.rb")
          end

          def add_views
            add_template('welcome.rb.tt', "lib/#{underscored_project_name}/views/welcome.rb")
          end

          def add_web
            add_template('example_routes.rb.tt', 'web/routes/example.rb')
            add_template('application.html.slim', 'web/templates/layouts/application.html.slim')
            add_template('welcome.html.slim', 'web/templates/welcome.html.slim')
          end
        end
      end
    end
  end
end
