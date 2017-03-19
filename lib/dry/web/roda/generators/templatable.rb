module Dry
  module Web
    module Roda
      module Generators
        module Templatable
          def self.included(base)
            base.extend ClassMethods
          end

          def templates
            self.class.templates
          end

          def add_template(source, target)
            self.class.add_template(source, target)
          end

          module ClassMethods
            def templates
              @templates ||= []
            end

            def add_template(source, target)
              templates << [source, target]
            end
          end
        end
      end
    end
  end
end
