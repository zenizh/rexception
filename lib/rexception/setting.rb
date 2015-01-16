require 'singleton'

module Rexception
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
end
