require "dry/web/roda/generate"

module Dry
  module Web
    module Roda
      module Generators
        class AbstractGenerator
          attr_reader :target_dir, :options

          def initialize(target_dir, options = {})
            @target_dir = target_dir
            @options = options
            @templates = []
            populate_templates
            @templates.freeze
          end


          def call
            templates.each do |source, target|
              generator.(source, target)
            end
            post_process_callback
          end

          private
          attr_reader :templates

          def generator
            @generator ||= Generate.new(destination, template_scope)
          end

          def post_process_callback; end

          def add_template(source, target)
            @templates << [source, target]
          end

          def underscored_project_name
            @underscored_project_name ||= Inflections.underscored_name(target_dir)
          end

          def template_scope
            fail NotImplementedError
          end

          def destination
            fail NotImplementedError
          end
        end
      end
    end
  end
end
