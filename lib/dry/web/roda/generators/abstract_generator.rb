require "dry/web/roda/generate"
require "dry/web/roda/generators/templatable"

module Dry
  module Web
    module Roda
      module Generators
        class AbstractGenerator
          include Templatable
          
          attr_reader :target_dir, :options

          def initialize(target_dir, options = {})
            @target_dir = target_dir
            @options = options
            populate_templates
          end

          def call
            templates.each do |source, target|
              generator.(source, target)
            end
            post_process_callback
          end

          private

          def generator
            @generator ||= Generate.new(destination, template_scope)
          end

          def post_process_callback; end

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
