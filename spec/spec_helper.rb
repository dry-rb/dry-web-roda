# encoding: utf-8

if RUBY_ENGINE == "rbx"
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

begin
  require 'byebug'
rescue LoadError; end

require 'pathname'
require 'rack/test'
require 'slim'

ENV['RACK_ENV'] = 'test'

SPEC_ROOT = Pathname(__FILE__).dirname

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.include Rack::Test::Methods, type: :request
end
