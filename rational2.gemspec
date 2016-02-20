# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rational2/version'

Gem::Specification.new do |spec|
  spec.name          = 'rational2'
  spec.version       = Rational2::VERSION
  spec.authors       = ['Daniel Dinu']
  spec.email         = ['dumitru-daniel.dinu@uni.lu']
  spec.description   = 'Support for rational numbers'
  spec.summary       = 'Rational numbers'
  spec.homepage      = 'https://github.com/daniel-dinu/rational-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codecov'
end
