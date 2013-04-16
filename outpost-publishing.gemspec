# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'outpost/publishing/version'

Gem::Specification.new do |spec|
  spec.name          = "outpost-publishing"
  spec.version       = Outpost::Publishing::VERSION
  spec.authors       = ["Bryan Ricker"]
  spec.email         = ["bricker88@gmail.com"]
  spec.description   = %q{Enhanced content publishing for Outpost.}
  spec.summary       = %q{Outpost plugin for publishing helper UI.}
  spec.homepage      = "https://github.com/SCPR/outpost-publishing"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
end
