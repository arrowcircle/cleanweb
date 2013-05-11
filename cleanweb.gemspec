# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cleanweb'

Gem::Specification.new do |spec|
  spec.name          = "cleanweb"
  spec.version       = Cleanweb::Version::VERSION
  spec.authors       = ["Oleg Bovykin"]
  spec.email         = ["oleg.bovykin@gmail.com"]
  spec.description   = %q{Gem for Yandex Cleanweb intergation}
  spec.summary       = %q{Yandex Cleanweb}
  spec.homepage      = "https://github.com/arrowcircle/cleanweb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
