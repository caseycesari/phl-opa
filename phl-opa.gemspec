# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phl_opa/version'

Gem::Specification.new do |spec|
  spec.name          = "phl-opa"
  spec.version       = PHLopa::VERSION
  spec.authors       = ["Casey Thomas"]
  spec.email         = ["cpthomas@gmail.com"]
  spec.description   = %q{A thin wrapper for the Philadelphia Office of Property Assessment API}
  spec.summary       = %q{Get information about properties in Philadelphia}
  spec.homepage      = "https://www.github.com/caseypt/phl-opa"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
