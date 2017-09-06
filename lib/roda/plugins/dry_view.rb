class Roda
  module RodaPlugins
    module DryView
      def self.configure(app, opts=OPTS)
        app.opts[:view_context_options] = opts.fetch(
          :view_context_options,
          {}
        )
      end

      def self.load_dependencies(app, opts=OPTS)
        app.plugin :csrf
        app.plugin :flash
        app.plugin :flow
      end

      module InstanceMethods
        def view_context
          self.class["view.context"].with(view_context_options)
        end

        def view_context_options
          {
            flash:        flash,
            csrf_token:   Rack::Csrf.token(request.env),
            csrf_metatag: Rack::Csrf.metatag(request.env),
            csrf_tag:     Rack::Csrf.tag(request.env),
          }.merge(opts[:view_context_options])
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
