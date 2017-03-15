require "pathname"
require "thor"

module Dry
  module Web
    module Roda
      class Generate
        TEMPLATES_DIR = "templates".freeze
        SOURCE_DIR = Pathname(__FILE__).dirname.join(TEMPLATES_DIR)

        attr_reader :processor, :target_dir

        def initialize(target_dir)
          @target_dir = target_dir
          @processor = Class.new(Thor) do
            include Thor::Actions
          end.new
          @processor.class.source_root SOURCE_DIR
        end

        def call(source, target, options)
          target_dir = Pathname.getwd + @target_dir
          target_file = target_dir + target
          template_file = SOURCE_DIR.each_child(false).find { |f| f.to_s == source }

          processor.template template_file, target_file, options
        end
      end
    end
  end
end
