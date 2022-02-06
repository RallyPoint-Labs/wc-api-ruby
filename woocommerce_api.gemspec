# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubygems'
require 'woocommerce_api/version'

Gem::Specification.new do |s|
  s.name        = 'woocommerce_api'
  s.version     = WooCommerce::VERSION
  s.date        = '2022-02-05'

  s.summary     = 'A Ruby wrapper for the WooCommerce API'
  s.description = 'This gem provide a wrapper to deal with the WooCommerce REST API'
  s.license     = 'MIT'

  s.authors     = ['Sky Mayhew', 'Claudio Sanches']
  s.email       = 'sky@rallypointlabs.com'
  s.files       = Dir['lib/woocommerce_api.rb', 'lib/woocommerce_api/*.rb']
  s.homepage    = 'https://github.com/woocommerce/wc-api-ruby'

  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.add_runtime_dependency 'faraday', '~> 2.2', '>= 2.0.0'
  s.add_runtime_dependency 'json', '~> 2.0', '>= 2.0.0'

  s.add_development_dependency 'rake', '~> 13.0.6'
  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'webmock', '~> 3.14.0'
end
