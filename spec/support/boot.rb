require "net/http"
require "uri"
require "waitutil"
require_relative "silently"

module RSpec
  module Support
    module Boot
      private

      class App
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

      def run_app(port = 3333)
        pid = fork {
          silently "bundle exec rackup config.ru -p #{port}", via: :exec
        }

        WaitUtil.wait_for_service "app", "0.0.0.0", port, timeout_sec: 10
        yield App.new(port)
      ensure
        Process.kill "TERM", pid
        Process.wait pid
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Boot, type: :cli
end
