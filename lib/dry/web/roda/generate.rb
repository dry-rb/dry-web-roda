require "pathname"
require "thor"

module Dry
  module Web
    module Roda
      class Generate
        TEMPLATES_DIR = "templates".freeze
        SOURCE_DIR = Pathname(__FILE__).dirname.join(TEMPLATES_DIR)

        attr_reader :target_dir, :template_scope, :template_files, :processor

        def initialize(target_dir, template_scope)
          @target_dir = target_dir
          @template_scope = template_scope
          @template_files = Dir[SOURCE_DIR.join('**/{.,}*')]

          @processor = Class.new(Thor) do
            include Thor::Actions
          end.new
          @processor.class.source_root SOURCE_DIR
        end

        def call(source, target)
          source = Pathname(source)
          aboslute_source_path = source.expand_path(SOURCE_DIR)
          target_file = get_target_file(target)
          template_file = template_files.find { |f| f == aboslute_source_path.to_s } or raise "missing template file +#{source}+"
          template_file = Pathname(template_file)

          processor.template template_file, target_file, template_scope

          create_executable(target_file) if executable?(template_file)
        end

        private

        def get_target_file(target)
          Pathname.getwd.join(target_dir, target)
        end

        def create_executable(file)
          FileUtils.chmod "a+x", file
        end

        def executable?(file)
          file.file? && file.executable?
        end
      end
    end
  end
end
