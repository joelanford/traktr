# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traktr/version'

Gem::Specification.new do |spec|
  spec.name          = "traktr"
  spec.version       = Traktr::VERSION
  spec.authors       = ["Joe Lanford"]
  spec.email         = ["joe.lanford@gmail.com"]
  spec.description   = %q{Implementation of the track.tv REST API.  See the documentation at http://trakt.tv/api-docs}
  spec.summary       = %q{Implementation of the track.tv REST API}
  spec.homepage      = "https://github.com/joelanford/traktr"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "= 0.11.0"
  spec.add_dependency "mash"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
