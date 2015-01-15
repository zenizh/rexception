class ExceptionsController < ActionController::Base
  STATUSES = Rack::Utils::SYMBOL_TO_STATUS_CODE.select { |_, code| code >= 400 }

  STATUSES.each do |status, _|
    eval <<-RUBY
      def #{status}
        render template_exists?(view) ? view : view(:internal_server_error)
      end
    RUBY
  end

  def view(status = status())
    "errors/#{status}"
  end

  def status
    self.class.status(env)
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

Rails.application.config.exceptions_app = ExceptionsController
