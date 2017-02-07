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

      def run_app(host: "0.0.0.0", port: "30333", timeout: 5)
        cmd = "bundle exec rackup -o 0.0.0.0 -p #{port} config.ru"
        out = Tempfile.new("dry-web-roda-out")

        pid = fork {
          Bundler.with_clean_env do
            exec cmd, out: out.path, err: out.path
          end
        }

        WaitUtil.wait_for_condition "app available on #{host}:#{port}", timeout_sec: timeout do
          begin
            result = WaitUtil.send(:is_tcp_port_open, host, port, WaitUtil::DEFAULT_DELAY_SEC)

            result || begin
              out.rewind
              [false, "#{cmd} failed:\n#{out.read}"]
            end
          rescue SocketError
            out.rewind
            [false, "#{cmd} failed:\n#{out.read}"]
          end
        end

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
