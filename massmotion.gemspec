# -*- encoding: utf-8 -*-
require File.expand_path('../lib/massmotion/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stephane Bellity", "Oahu"]
  gem.email         = ["sbellity@gmail.com", "dev@oahu.fr"]
  gem.description   = %q{MassMotion Media API Client}
  gem.summary       = %q{MassMotion Media API Client}
  gem.homepage      = "http://oahu.fr"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "massmotion"
  gem.require_paths = ["lib"]
  gem.version       = Massmotion::VERSION

  # Dependencies
  gem.add_dependency 'faraday',               '>= 0.7'
  gem.add_dependency 'faraday_middleware',    '>= 0.7'
  gem.add_dependency 'multi_json',            '>= 1.0'
  gem.add_dependency 'hashie',                '~> 1.0'
  
end
