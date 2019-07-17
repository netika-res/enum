# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enum/version'

Gem::Specification.new do |spec|
  spec.name          = "safe-hash-enum"
  spec.version       = Enum::VERSION
  spec.authors       = ["NETIKA real estate solution s.a."]
  spec.email         = ["pierre.streel@netika.com"]

  spec.summary       = %q{Enum implementation}
  spec.description   = %q{This is a implementation of enums in Ruby.}
  spec.homepage      = "https://github.com/netika-res/enum"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "i18n"
end
