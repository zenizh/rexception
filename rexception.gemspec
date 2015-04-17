$:.unshift File.expand_path('../lib', __FILE__)

require 'rexception/version'

Gem::Specification.new do |s|
  s.name        = 'rexception'
  s.version     = Rexception::VERSION
  s.authors     = 'kami'
  s.email       = 'kami30k@gmail.com'
  s.homepage    = 'https://github.com/kami30k/rexception'
  s.summary     = 'Rendering error pages for Rails application.'
  s.description = 'Rendering error pages for Rails application.'
  s.license     = 'MIT'

  s.files = `git ls-files -z`.split("\x0")

  s.add_dependency 'rails'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
end
