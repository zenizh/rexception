require 'singleton'

module ExceptionsApp
  class << self
    def setup(&block)
      Setting.instance.setup(&block)
    end

    def setting
      Setting.instance
    end
  end

  class Setting
    include Singleton

    attr_accessor :layout
    attr_accessor :errors_dir
    attr_accessor :rescue_responses

    def initialize
      defaults.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def setup
      yield self
    end

    private

    def defaults
      @defaults ||= {
        layout:     'application',
        errors_dir: 'errors',
        rescue_responses: {}
      }
    end
  end

  class ExceptionsController < ActionController::Base
    STATUSES = Rack::Utils::SYMBOL_TO_STATUS_CODE.select { |_, code| code >= 400 }

    STATUSES.each do |status, code|
      eval <<-RUBY
        def #{status}
          render template_exists?(view) ? view : view(:internal_server_error), status: #{code}
        end
      RUBY
    end

    layout -> { setting.layout }

    private

    def view(status = status())
      "#{setting.errors_dir}/#{status}"
    end

    def status
      self.class.status(env)
    end

    def setting
      ExceptionsApp.setting
    end

    class << self
      def call(env)
        action(status(env)).call(env)
      end

      def status(env)
        ActionDispatch::ExceptionWrapper.rescue_responses[exception(env).class.name]
      end

      def exception(env)
        env['action_dispatch.exception']
      end
    end
  end
end

ExceptionsApp.setup do |config|
  config.layout = 'application'

  config.errors_dir = 'errors'

  config.rescue_responses = {
  }
end

Rails.application.config.exceptions_app = ExceptionsApp::ExceptionsController
