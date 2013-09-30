# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linklocator_direct_API/version'

Gem::Specification.new do |spec|
  spec.name          = "linklocator_direct_API"
  spec.version       = LinklocatorDirectAPI::VERSION
  spec.authors       = ["Kirk Jarvis"]
  spec.email         = ["zuuzlo@yahoo.com"]
  spec.description   = %q{Wrapper for LinkShare LinkLocator Direct Rest Service}
  spec.summary       = %q{This wrapper use of the LinkShare LinkLocator Direct API to download different link types for all the advertisers whose programs you particiapate in.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "addressable", "~> 2.3.5"
  spec.add_dependency "httparty", "~> 0.11.0"
  spec.add_dependency "recursive-open-struct", "~> 0.4.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "guard-test"
end
