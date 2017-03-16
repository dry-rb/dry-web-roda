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
