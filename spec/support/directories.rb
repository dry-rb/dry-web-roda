require "fileutils"

module RSpec
  module Support
    module Directory
      private

      def with_directory(directory)
        current = Dir.pwd
        target  = Pathname.new(Dir.pwd).join(directory)

        Dir.chdir(target)
        yield
      ensure
        Dir.chdir(current)
      end

      def with_tmp_directory
        dir = Pathname.new("tmp").join("aruba")

        with_directory(dir) do
          yield
        end
      ensure
        FileUtils.rm_rf(dir) unless ENV['CLEAR_TMP'].eql?('false')
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Directory, type: :cli

  config.before :suite do
    Pathname.new(Dir.pwd).join("tmp").mkpath
  end
end
