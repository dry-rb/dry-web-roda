require "dry/web/roda/generators/abstract_generator"

module Dry
  module Web
    module Roda
      module Generators
        class SubApp < AbstractGenerator
          def populate_templates
            add_lib
            add_system
            add_web
          end

          private

          def destination
            options.fetch(:to) { File.join("apps", target_dir) }
          end

          def umbrella_name
            options.fetch(:umbrella)
          end

          def underscored_umbrella_name
            Inflections.underscored_name(umbrella_name)
          end

          def lib_path
            "lib/#{underscored_umbrella_name}/#{underscored_project_name}"
          end

          def system_lib_path
            "system/#{underscored_umbrella_name}/#{underscored_project_name}"
          end

          def add_lib
            add_template('subapp/view__context.rb.tt', "#{lib_path}/view/context.rb")
            add_template('subapp/view__controller.rb.tt', "#{lib_path}/view/controller.rb")
            add_template('subapp/welcome.rb.tt', "#{lib_path}/views/welcome.rb")
          end

          def add_system
            add_template('subapp/application.rb.tt', "#{system_lib_path}/application.rb")
            add_template('subapp/container.rb.tt', "#{system_lib_path}/container.rb")
            add_template('subapp/import.rb.tt', "#{system_lib_path}/import.rb")
            add_template('subapp/boot.rb.tt', 'system/boot.rb')
          end

          def add_web
            add_template('subapp/example_routes.rb.tt', 'web/routes/example.rb')
            add_template('application.html.slim', 'web/templates/layouts/application.html.slim')
            add_template('welcome.html.slim', 'web/templates/welcome.html.slim')
          end

          def template_scope
            {
              underscored_project_name: underscored_project_name,
              camel_cased_app_name: Inflections.camel_cased_name(target_dir),
              underscored_umbrella_name: underscored_umbrella_name,
              camel_cased_umbrella_name: Inflections.camel_cased_name(umbrella_name),
            }
          end
        end
      end
    end
  end
end
