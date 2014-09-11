# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ark_tweet_nlp/version'

Gem::Specification.new do |spec|
  spec.name          = "ark_tweet_nlp"
  spec.version       = ArkTweetNlp::VERSION
  spec.authors       = ["Bernardo"]
  spec.email         = ["bersimoes@gmail.com"]
  spec.summary       = %q{Ruby wrapper for the Carnegie Mellon Twitter NLP}
  spec.description   = %q{Tags tweets word into multiple cathegories using NLP}
  spec.homepage      = "https://github.com/golfadas/ark_tweet_nlp_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "pry"
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'pry-rescue'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
end
