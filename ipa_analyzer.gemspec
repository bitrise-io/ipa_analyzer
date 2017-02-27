# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "ipa_analyzer/version"

Gem::Specification.new do |s|
  s.name        = "ipa_analyzer"
  s.authors     = ["Bitrise", "Viktor Benei"]
  s.email       = 'letsconnect@bitrise.io'
  s.license     = "MIT"
  s.homepage    = "https://github.com/bitrise-io/ipa_analyzer"
  s.version     = IpaAnalyzer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "iOS .ipa analyzer"
  s.description = "Analyze an iOS .ipa file. Can be used as a CLI and can print the information in JSON so it can be used by other tools."

  s.add_runtime_dependency 'plist', '~> 3.1', '>= 3.1.0'
  s.add_runtime_dependency 'rubyzip', '~> 1.1.7', '>= 1.1.7'

  s.add_development_dependency "rspec"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rake"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ['ipa_analyzer']
  s.require_paths = ["lib"]
end
