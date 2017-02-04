require "net/http"
require "uri"
require "waitutil"
require_relative "silently"

module RSpec
  module Support
    module App
      private

      class RunningApp
        attr_reader :port

        def initialize(port)
          @port = port
        end

        def get(path)
          Net::HTTP.get(uri(path))
        end

        private

        def uri(path)
          URI("http://0.0.0.0:#{port}#{path}")
        end
      end

      def run_app(port = 30333)
        pid = fork {
          # silently "bundle exec rackup -o 0.0.0.0 -p #{port} config.ru", via: :exec
          ::Bundler.with_clean_env do
            exec "bundle exec rackup -o 0.0.0.0 -p #{port} config.ru"
          end
        }

        WaitUtil.wait_for_service "app", "0.0.0.0", port, timeout_sec: 10
        yield RunningApp.new(port)
      ensure
        Process.kill "TERM", pid
        Process.wait pid
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::App, type: :cli
end
