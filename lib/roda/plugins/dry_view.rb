class Roda
  module RodaPlugins
    module DryView
      def self.load_dependencies(app)
        app.plugin :flow
      end

      module InstanceMethods
        def view_context
          self.class["view.context"].with(view_context_options)
        end

        def view_context_options
          {}
        end
      end

      module RequestMethods
        def view(name, options = {})
          options = {context: scope.view_context}.merge(options)
          is to: "views.#{name}", call_with: [options]
        end
      end
    end

    register_plugin :dry_view, DryView
  end
end
