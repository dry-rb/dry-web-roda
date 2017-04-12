require "dry/web/roda/generators/abstract_generator"

module Dry
  module Web
    module Roda
      module Generators
        class SubApp < AbstractGenerator
          def populate_templates
            add_lib
            add_system
            add_transactions
            add_web
          end

          private

          def destination
            options.fetch(:to) { File.join("apps", target_dir) }
          end

          def umbrella_name
            options.fetch(:umbrella)
          end

          def add_lib
            add_template('welcome.rb.tt', "lib/#{underscored_project_name}/views/welcome.rb")
            add_template('.keep', "lib/#{underscored_project_name}/.keep")
          end

          def add_system
            %w(application container transactions view_context view_controller).each do |file|
              add_template("subapp/#{file}.rb.tt", "system/#{underscored_project_name}/#{file}.rb")
            end
            add_template('import.rb.tt', "system/#{underscored_project_name}/import.rb")
            add_template('subapp/view.rb.tt', 'system/boot/view.rb')
            add_template('subapp/boot.rb.tt', 'system/boot.rb')
          end

          def add_transactions
            add_template('subapp/example.rb.tt', 'transactions/example.rb')
          end

          def add_web
            add_template('example_routes.rb.tt', 'web/routes/example.rb')
            add_template('application.html.slim', 'web/templates/layouts/application.html.slim')
            add_template('welcome.html.slim', 'web/templates/welcome.html.slim')
          end

          def template_scope
            {
              underscored_project_name: underscored_project_name,
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
