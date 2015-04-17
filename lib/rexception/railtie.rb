module Rexception
  class Railtie < Rails::Railtie
    initializer 'rexception' do |app|
      app.config.exceptions_app = Rexception::ExceptionsController
    end
  end
end
