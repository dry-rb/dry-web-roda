require 'dry-monads'
require 'main/entities/user'
require 'main/import'

module Main
  module Transactions
    class RegisterUser
      include Dry::Monads::Either::Mixin

      include Main::Import['persistence.db']

      def call(params)
        if params['name']
          Right(db[:users] << Main::Entities::User.new(*params.values_at('id', 'name')))
        else
          Left(validation: 'name is missing')
        end
      end
    end
  end
end
