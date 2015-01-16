$:.push File.expand_path('../lib', __FILE__)

require 'rexception/version'

Gem::Specification.new do |s|
  s.name        = 'rexception'
  s.version     = Rexception::VERSION
  s.authors     = ['kami']
  s.email       = ['kami30k@gmail.com']
  s.homepage    = 'https://github.com/kami30k/rexception'
  s.summary     = 'Rendering error pages for Rails application.'
  s.description = 'Rendering error pages for Rails application.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.0'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
end
