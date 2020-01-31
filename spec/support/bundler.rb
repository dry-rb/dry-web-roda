require 'open3'
require 'pathname'
require_relative 'env'
require_relative 'silently'
require_relative 'files'

module RSpec
  module Support
    module Bundler
      def self.root
        Pathname.new(__dir__).join("..", "..")
      end

      def self.cache
        root.join("vendor", "cache")
      end

      def self.setup
        return if cache.exist?

        with_clean_env do
          RSpec::Support.silently "./script/setup"
        end
      end

      def self.with_clean_env(&blk)
        ::Bundler.with_unbundled_env(&blk)
      end

      private

      attr_reader :out, :err, :exitstatus

      def setup_gemfile(gems: [], exclude_gems: [], path: "Gemfile")
        filtered_content = ::File.readlines(path).
                             drop(1).
                             reject { |l| exclude_gems.any? { |g| l.include?(g) } }

        content = ["source 'file://#{cache}'\n"] + filtered_content + gems.map { |g| "gem #{g}\n" }

        rewrite(path, content)
      end

      def bundle_install
        bundle "install --local --no-cache --retry 0 --no-color"
      end

      def bundle_exec(cmd, env: nil, &blk)
        bundle("exec #{cmd}", env: env, &blk)
      end

      def bundle(cmd, env: nil, &blk)
        ruby_bin   = which("ruby")
        bundle_bin = which("bundle")
        rack_env = "RACK_ENV=#{env} " unless env.nil?

        system_exec("#{rack_env}#{ruby_bin} -I#{load_paths} #{bundle_bin} #{cmd}", &blk)
      end

      # Adapted from Bundler source code
      #
      # Bundler is released under MIT license
      # https://github.com/bundler/bundler/blob/master/LICENSE.md
      #
      # A special "thank you" goes to Bundler maintainers and contributors.
      #
      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def system_exec(cmd)
        Open3.popen3(RSpec::Support::Env.env, cmd) do |stdin, stdout, stderr, wait_thr|
          yield stdin, stdout, wait_thr if block_given?
          stdin.close

          @exitstatus = wait_thr && wait_thr.value.exitstatus
          @out = Thread.new { stdout.read }.value.strip
          @err = Thread.new { stderr.read }.value.strip
        end

        (@all_output ||= "") << [
          "$ #{cmd.to_s.strip}",
          out,
          err,
          @exitstatus ? "# $? => #{@exitstatus}" : "",
          "\n"
        ].reject(&:empty?).join("\n")

        @out
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize

      def load_paths
        [root.join('lib'), root.join('spec')].join(':')
      end

      def root
        RSpec::Support::Bundler.root
      end

      def cache
        RSpec::Support::Bundler.cache
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Bundler, type: :cli

  config.before(:all, type: :cli) do
    RSpec::Support::Bundler.setup
  end
end
