# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rate_theme/version'

Gem::Specification.new do |spec|
  spec.name          = "rate_theme"
  spec.version       = RateTheme::VERSION
  spec.authors       = ["hayduke19us"]
  spec.email         = ["hayduke19us@gmail.com"]
  spec.summary       = %q{rate your zsh themes and keep track of favorites}
  spec.description   = %q{Start with random in your zshrc file. 
  Log your favorite themes with 'rate_theme' and dynamically change
  your current theme to the highest rated.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.executables    = ["rate_theme"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "ZenTest"
  spec.add_development_dependency "autotest-fsevent"
  spec.add_runtime_dependency "colorize"
end
