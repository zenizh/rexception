require 'rexception/version'
require 'rexception/railtie' if defined?(Rails)

module Rexception
  autoload :ExceptionsController, 'rexception/exceptions_controller'

  class << self
    # Layout file name to use for rendering error page.
    #
    # @return [String]
    attr_accessor :layout

    # Directory name where you place error pages.
    #
    # @return [String]
    attr_accessor :errors_dir

    # Pairs of custom exceptions and statuses.
    #
    # @return [Hash{String => Symbol}]
    def rescue_responses=(rescue_responses)
      ActionDispatch::ExceptionWrapper.rescue_responses.merge!(rescue_responses)
    end

    # Configuring module attributes by initializer.
    #
    # @yield Rexception
    def configure
      yield self
    end
  end
end

require 'rexception/config'
