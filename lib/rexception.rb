require 'rexception/version'
require 'rexception/controller'
require 'rexception/railtie' if defined?(Rails)

module Rexception
  autoload :Setting, 'rexception/setting'

  class << self
    def setup(&block)
      Setting.instance.setup(&block)
    end

    def setting
      Setting.instance
    end
  end
end
