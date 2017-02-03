require "tempfile"

module RSpec
  module Support
    def self.silently(cmd, via: :system)
      out    = Tempfile.new("dry-web-roda-out")
      result = ::Kernel.__send__(via, cmd, out: out.path, err: out.path)

      return if result

      out.rewind
      fail "#{cmd} failed:\n#{out.read}" # rubocop:disable Style/SignalException
    end

    module Silently
      private

      def silently(*args)
        Support.silently(*args)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Silently, type: :cli
end
