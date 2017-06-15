require "waitutil"
require_relative 'env'
require_relative 'silently'
require_relative 'bundler'
require_relative 'directories'

module RSpec
  module Support
    module Project
      private

      KNOWN_ARGUMENTS = [:arch].freeze

      def with_project(name = "sandbox", **args)
        with_tmp_directory do
          create_project name, args

          within_project_directory(name) do
            setup_gemfile gems: ["'dry-web-roda', path: '#{root}'"], exclude_gems: ['dry-web-roda']
            bundle_install
            yield
          end
        end
      end

      def within_project_directory(project)
        cd(project.to_s) do
          # Aruba resets ENV and its API to set new env vars is broken.
          #
          # We need to manually setup the following env vars:
          #
          # ENV["PATH"] is required by Capybara's selenium/poltergeist drivers
          ENV["PATH"] = RSpec::Support::Env.fetch_from_original("PATH")
          # Bundler on CI can't find HOME and it fails to run Hanami commands
          ENV["HOME"] = RSpec::Support::Env.fetch_from_original("HOME")

          yield
        end
      end

      def create_project(name, args)
        silently "dry-web-roda new #{name} #{_create_project_args(args)}"
      end

      def _create_project_args(args)
        return if args.empty?

        flags = args.dup.keep_if { |k, _| KNOWN_ARGUMENTS.include?(k) }

        flags.map { |arg, value|
          "--#{arg}=#{value}"
        }.join(" ")
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Support::Project, type: :cli
end
