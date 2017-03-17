require "pathname"
require "thor"

module Dry
  module Web
    module Roda
      class Generate
        TEMPLATES_DIR = "templates".freeze
        SOURCE_DIR = Pathname(__FILE__).dirname.join(TEMPLATES_DIR)

        attr_reader :processor, :target_dir, :template_scope

        def initialize(target_dir, template_scope)
          @target_dir = target_dir
          @template_scope = template_scope
          @processor = Class.new(Thor) do
            include Thor::Actions
          end.new
          @processor.class.source_root SOURCE_DIR
        end

        def call(source, target)
          target_dir = Pathname.getwd + @target_dir
          target_file = target_dir + target
          template_file = SOURCE_DIR.each_child(false).find { |f| f.to_s == source }

          template_file = find_template_inside_folders(source) unless template_file

          processor.template template_file, target_file, template_scope
        end

        def find_template_inside_folders(source)
          directories = SOURCE_DIR.each_child.select { |f| f.directory? }
          file = nil
          directories.each do |directory|
            file ||= directory.each_child(false).find { |f| f == Pathname(source).basename }
          end
          file.expand_path(SOURCE_DIR + 'subapp')
        end
      end
    end
  end
end
