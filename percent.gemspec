# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name     = 'percent'
  s.version  = '0.1.0'
  s.platform = Gem::Platform::RUBY
  s.license  = 'MIT'
  s.authors  = ['Joe Kennedy']
  s.email    = ['joseph.stephen.kennedy@gmail.com']
  s.summary  = 'Percent objects and integration with Rails'
  s.homepage = 'https://github.com/JoeKennedy/percent'

  s.files = Dir.glob('{lib,spec}/**/*') + %w[percent.gemspec]
  s.files.delete 'spec/percent.sqlite3'

  s.require_path = 'lib'

  s.add_dependency 'activesupport', '~> 7'
  s.metadata['rubygems_mfa_required'] = 'true'
end
