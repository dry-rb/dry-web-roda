require "pathname"
require "thor"

module Dry
  module Web
    module Roda
      class Generate
        SKELETONS_DIR = "skeletons".freeze

        attr_reader :source_dir
        attr_reader :processor

        def initialize(skeleton_name)
          @source_dir = Pathname(__FILE__).dirname.join(SKELETONS_DIR).join(skeleton_name)

          @processor = Class.new(Thor) do
            include Thor::Actions
          end.new
          @processor.class.source_root source_dir
        end

        def call(target_dir, scope = {})
          target_dir = Pathname.getwd + target_dir
          source_files = Dir[source_dir.join("**/{.,}*")]

          source_files.select { |f| File.file?(f) }.each do |source_file|
            source_file = Pathname(source_file).relative_path_from(source_dir)
            target_file = target_dir + source_file

            if scope.any?
              target_file = target_file.to_s.gsub(/__#{Regexp.union(scope.keys.map(&:to_s))}__/) { |match|
                scope_key = match.gsub(/^__/, "").gsub(/__$/, "")
                scope.fetch(scope_key.to_sym)
              }
            end

            if source_file.extname == Thor::TEMPLATE_EXTNAME
              processor.template source_file, target_file.sub(/#{Thor::TEMPLATE_EXTNAME}$/, ""), scope
            else
              processor.copy_file source_file, target_file
            end
          end
        end
      end
    end
  end
end
