# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/swagger-exposer/version'

excluded_patterns = ['test/', 'example/', '.travis.yml', '.github/', '.gitignore']

Gem::Specification.new do |spec|
  spec.name = 'sinatra-swagger-exposer'
  spec.version = Sinatra::SwaggerExposer::VERSION
  spec.authors = ['Julien Kirch']

  spec.summary = %q{Expose swagger API from your Sinatra app}
  spec.description = %q{This Sinatra extension enable you to add metadata to your code to expose your API as a Swagger endpoint and to validate and enrich the invocation parameters}
  spec.homepage = 'https://github.com/archiloque/sinatra-swagger-exposer'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| excluded_patterns.any? { |ep| f.start_with?(ep) } }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.7.8'

  spec.add_dependency 'sinatra', '>= 2.1', '< 5.0'
  spec.add_dependency 'mime-types', '~> 3.4'
  # Rack 2.x requires this after it was extracted from the Ruby standard library.
  spec.add_dependency 'ostruct'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'rack-test', '~> 2.0'
  spec.add_development_dependency 'simplecov'

end
