require "dry/web/roda/generate"

module Dry
  module Web
    module Roda
      module Generators
        class AbstractProject
          attr_reader :target_dir, :options

          def initialize(target_dir, options = {})
            @target_dir = target_dir
            @options = options
            @generator = Generate.new(destination)
            @templates = []
          end


          def call
            map_templates.each do |source, target|
              @generator.(source, target, prepare_scope)
            end
            post_process_callback
          end

          def post_process_callback; end

          def destination
            fail NotImplementedError
          end

          def underscored_app_name
            @underscored_app_name ||= Inflections.underscored_name(target_dir)
          end

          def prepare_scope
            fail NotImplementedError
          end

          def add_template(source, target)
            @templates << [source, target]
          end

          def add_bin
            add_template('console.tt', 'bin/console')
            add_template('setup', 'bin/setup')
          end

          def add_config
            add_template('settings.yml.tt', 'config/settings.yml')
          end

          def add_db
            add_template('sample_data.rb', 'db/sample_data.rb')
            add_template('seed.rb', 'db/seed.rb')
          end

          def add_lib
            add_template('welcome.rb.tt', "lib/#{underscored_app_name}/views/welcome.rb")
            add_template('.keep', "lib/#{underscored_app_name}/.keep")
            add_template('.keep', 'lib/persistance/commands/.keep')
            add_template('.keep', 'lib/persistance/relations/.keep')
            add_template('types.rb', 'lib/types.rb')
          end

          def add_log
            add_template('.keep', 'log/.keep')
          end

          def add_specs
            add_template('test_factories.rb', 'spec/support/db/test_factories.rb')
            add_template('test_helpers.rb.tt', 'spec/support/test_helpers.rb')
            add_template('app_helper.rb', 'spec/app_helper.rb')
            add_template('db_helper.rb.tt', 'spec/db_helper.rb')
            add_template('spec_helper.rb.tt', 'spec/spec_helper.rb')
          end

          def add_system
            add_system_app_folder
            add_system_boot
          end

          def add_system_app_folder
            %w(application container import repository settings transactions view_context view_controller).each do |file|
              add_template("#{file}.rb.tt", "system/#{underscored_app_name}/#{file}.rb")
            end
          end

          def add_system_boot
            %w(monitor rom view).each do |file|
              add_template("#{file}.rb.tt", "system/boot/#{file}.rb")
            end
            add_template('boot.rb.tt', 'system/boot.rb')
          end

          def add_transactions
            add_template('example.rb.tt', 'transactions/example.rb')
          end

          def add_web
            add_template('example_routes.rb.tt', 'web/routes/example.rb')
            add_template('application.html.slim', 'web/templates/layouts/application.html.slim')
            add_template('welcome.html.slim', 'web/templates/welcome.html.slim')
          end

          def add_config_files
            add_template('.gitignore', '.gitignore')
            add_template('Gemfile', 'Gemfile')
            add_template('Rakefile.tt', 'Rakefile')
            add_template('README.md.tt', 'README.md')
          end
        end
      end
    end
  end
end
