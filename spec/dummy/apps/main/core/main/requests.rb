require_relative 'container'
require 'dry-transaction'

module Main
  module Requests
    class Registrar
      attr_reader :container

      def initialize(container)
        @container = container
      end

      def define(identifier, &block)
        container.register(identifier, Dry.Transaction(container: container, &block))
      end
    end

    def self.define(&block)
      yield(Registrar.new(Container))
    end
  end
end
