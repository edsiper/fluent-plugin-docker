# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-docker"
  spec.version       = "0.1.0"
  spec.authors       = ["Eduardo Silva"]
  spec.email         = ["eduardo@treasure-data.com"]

  spec.summary       = %q{fluentd plugin to handle and format Docker logs.}
  spec.description   = %q{fluentd plugin to handle and format Docker logs.}
  spec.homepage      = "https://github.com/edsiper/fluent-plugin-docker"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("yajl-ruby", ["~> 1.0"])
  spec.add_runtime_dependency("fluentd", ">= 0.12.0")
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.2.0"
end
