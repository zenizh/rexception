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

    def initialize
      defaults.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def setup
      yield self
    end

    def rescue_responses=(rescue_responses)
      ActionDispatch::ExceptionWrapper.rescue_responses.merge!(rescue_responses)
    end

    private

    def defaults
      @defaults ||= {
        layout:     'application',
        errors_dir: 'errors'
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
  # Specify the layout file to use for rendering error page.
  # config.layout = 'application'

  # Specify the directory where you place error pages.
  # config.errors_dir = 'errors'

  # Define which of statuses return against custom exceptions.
  # config.rescue_responses = {
  #   'CustomException' => :not_found
  # }
end

Rails.application.config.exceptions_app = ExceptionsApp::ExceptionsController
