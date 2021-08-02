# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name = 'welcome_email_component'
  spec.version = '0.0.0'
  spec.summary = 'Welcome Email Component'
  spec.description = ' '

  spec.authors = ['Joseph Choe']
  spec.email = ['joseph@josephchoe.com']
  spec.homepage = 'https://github.com/bluepuppetcompany/welcome-email-component'

  spec.require_paths = ['lib']
  spec.files = Dir.glob('{lib}/**/*')
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6'

  spec.add_runtime_dependency 'eventide-postgres'

  spec.add_runtime_dependency 'smtp-email'
  spec.add_runtime_dependency 'registration-client'

  spec.add_development_dependency 'test_bench'
end
