require 'action_controller/railtie'
require 'action_view/railtie'

require 'rexception'

module Dummy
  class Application < Rails::Application
    config.secret_token = 'abcdefghijklmnopqrstuvwxyz0123456789'
    config.session_store :cookie_store, key: '_dummy_session'
    config.eager_load = false
    config.active_support.deprecation = :log
  end
end

Dummy::Application.initialize!

Dummy::Application.routes.draw do
  get '/forbidden',             to: 'errors#forbidden'
  get '/internal_server_error', to: 'errors#internal_server_error'
end

class CustomException < StandardError
end

class ApplicationController < ActionController::Base
end

class ErrorsController < ApplicationController
  def forbidden
    raise CustomException
  end

  def internal_server_error
    raise Exception
  end
end

Rexception.setup do |config|
  config.layout = 'layout'

  config.errors_dir = 'errors_dir'

  config.rescue_responses = {
    'CustomException' => :forbidden
  }
end
