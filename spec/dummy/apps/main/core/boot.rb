require_relative 'main/container'

Main::Container.finalize! do |container|
  require 'logger'
  container.register(:logger, Logger.new(container.root.join('log/app.log')))
end

require 'main/application'
require 'main/view'
require 'main/requests'

Main::Container.require('requests/**/*.rb')
