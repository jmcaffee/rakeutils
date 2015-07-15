# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rakeutils/version'

Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = "rakeutils"
  spec.version       = RakeUtils::VERSION
  spec.authors       = ["Jeff McAffee"]
  spec.email         = ["jeff@ktechsystems.com"]
  spec.description   = %q{Rake Utility classes}
  spec.summary       = %q{Rake Utility classes}
  spec.homepage      = "http://gems.ktechdesign.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake"
  #spec.add_runtime_dependency "win32ole"
  #spec.add_runtime_dependency "ktcommon"
  spec.add_runtime_dependency "ktutils"
end
