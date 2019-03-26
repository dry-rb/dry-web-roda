# frozen_string_literal: true

class Roda
  module RodaPlugins
    module DryView
      def self.load_dependencies(app)
        app.plugin :flow
      end

      module InstanceMethods
        def view_context
          self.class["view_context"].with(view_context_options)
        end

        def view_context_options
          {}
        end

        def view_key(name)
          "views.#{name}"
        end
      end

      module RequestMethods
        def view(name, options = {})
          resolve(scope.view_key(name)) do |renderer|
            renderer.call({ context: scope.view_context }.merge(options)).to_s
          end
        end
      end
    end

    register_plugin :dry_view, DryView
  end
end
