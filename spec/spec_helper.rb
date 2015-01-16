require 'dummy/application'

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
end
