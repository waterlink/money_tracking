# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money_tracking/version'

Gem::Specification.new do |spec|
  spec.name          = "money_tracking"
  spec.version       = MoneyTracking::VERSION
  spec.authors       = ["Oleksii Fedorov"]
  spec.email         = ["waterlink000@gmail.com"]
  spec.summary       = %q{CLI tool for tracking your expenses.}
  spec.description   = %q{CLI tool for tracking your expenses.}
  spec.homepage      = "https://github.com/waterlink/money_tracking"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
