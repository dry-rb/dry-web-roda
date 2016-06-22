require "roda"
require "rack/csrf"

class Roda
  module RodaPlugins
    module Page
      module InstanceMethods
        def current_page
          page.with_flash(flash)
        end

        def page
          self.class["page"].with(
            csrf_token: -> { Rack::Csrf.token(request.env) },
            csrf_metatag: -> { Rack::Csrf.metatag(request.env) },
            csrf_tag: -> { Rack::Csrf.tag(request.env) },
          )
        end
      end
    end

    module View
      module RequestMethods
        def view(name, overrides = {})
          options = {scope: scope.current_page}.merge(overrides)
          is to: "#{scope.name}.views.#{name}", call_with: [options]
        end
      end
    end

    register_plugin :page, Page
    register_plugin :view, View
  end
end
