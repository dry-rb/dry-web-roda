require "securerandom"
require "dry/web/roda/generators/abstract_generator"

module Dry
  module Web
    module Roda
      module Generators
        class AbstractProject < AbstractGenerator
          def populate_templates
            add_bin
            add_config
            add_db
            add_log
            add_spec
            add_lib
            add_system
            add_boot
            add_application
            add_config_files
          end

          private

          def destination
            target_dir
          end

          def template_scope
            {
              underscored_project_name: underscored_project_name,
              camel_cased_app_name: Inflections.camel_cased_name(target_dir)
            }
          end

          def add_bin
            add_template('console.tt', 'bin/console')
            add_template('setup', 'bin/setup')
          end

          def add_config
            add_template('.env.tt', '.env')
            add_template('.env.test.tt', '.env.test')
          end

          def add_db
            add_template('sample_data.rb', 'db/sample_data.rb')
            add_template('seed.rb', 'db/seed.rb')
          end

          def add_lib
            add_template('types.rb', 'lib/types.rb')
            add_template('operation.rb.tt', "lib/#{underscored_project_name}/operation.rb")
            add_template('repository.rb.tt', "lib/#{underscored_project_name}/repository.rb")
            add_template('.keep', 'lib/persistence/relations/.keep')
            add_template('.keep', 'lib/persistence/commands/.keep')
            add_template('view__context.rb.tt', "lib/#{underscored_project_name}/view/context.rb")
            add_template('view__controller.rb.tt', "lib/#{underscored_project_name}/view/controller.rb")
          end

          def add_log
            add_template('.keep', 'log/.keep')
          end

          def add_spec
            add_template('.rspec', '.rspec')

            # Base spec helpers
            add_template('spec/web_spec_helper.rb', 'spec/web_spec_helper.rb')
            add_template('spec/db_spec_helper.rb.tt', 'spec/db_spec_helper.rb')
            add_template('spec/spec_helper.rb.tt', 'spec/spec_helper.rb')

            # DB support
            add_template('spec/support/db/factory.rb', 'spec/support/db/factory.rb')
            add_template('spec/support/db/helpers.rb.tt', 'spec/support/db/helpers.rb')
            add_template('spec/factories/example.rb', 'spec/factories/example.rb')

            # Web support
            add_template('spec/support/web/helpers.rb.tt', 'spec/support/web/helpers.rb')
          end

          def add_system
            add_system_lib
            add_system_boot
          end

          def add_boot
            raise NotImplementedError
          end

          def add_application
            raise NotImplementedError
          end

          def add_system_lib
            add_template("container.rb.tt", "system/#{underscored_project_name}/container.rb")
            add_template("import.rb.tt", "system/#{underscored_project_name}/import.rb")
          end

          def add_system_boot
            add_template("monitor.rb.tt", "system/boot/monitor.rb")
            add_template("persistence.rb.tt", "system/boot/persistence.rb")
            add_template("settings.rb.tt", "system/boot/settings.rb")
          end

          def add_config_files
            add_template('.gitignore', '.gitignore')
            add_template('Gemfile.tt', 'Gemfile')
            add_template('Rakefile.tt', 'Rakefile')
            add_template('config.ru.tt', 'config.ru')
            add_template('README.md.tt', 'README.md')
          end
        end
      end
    end
  end
end
