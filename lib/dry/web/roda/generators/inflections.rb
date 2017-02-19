require "inflecto"

module Dry
  module Web
    module Roda
      module Generators
        module Inflections
          module_function

          def underscored_name(name)
            Inflecto.underscore(name)
          end

          def camel_cased_name(name)
            Inflecto.camelize(underscored_name(name))
          end
        end
      end
    end
  end
end
