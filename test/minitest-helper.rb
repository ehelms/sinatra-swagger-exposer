ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  add_group 'lib', 'lib'
  add_filter 'test'
end

unless ENV['NO_COVERALLS'] || ENV['COVERALLS_REPO_TOKEN'].to_s.empty?
  require 'coveralls'
  Coveralls.setup!
end

require 'minitest/autorun'
