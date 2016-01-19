$LOAD_PATH << File.expand_path('lib', __dir__)
require 'bit_table'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'bit_table'
  s.summary     = 'A bit array/table implementation'
  s.description = 'If you ever needed to create a bit table for whatever reason.'
  s.date        = Time.now.to_date.to_s
  s.version     = BitTable::VERSION
  s.homepage    = 'https://github.com/IceDragon200/bit_table/'
  s.license     = 'MIT'
  s.authors     = ['Corey Powell']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'codeclimate-test-reporter'

  s.require_path = 'lib'
  s.files = ['Gemfile', 'README.md']
  s.files.concat Dir.glob('{lib,spec}/**/*.{rb}')
end

