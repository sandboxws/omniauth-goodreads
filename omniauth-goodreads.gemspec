# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-goodreads/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ahmed El.Hussaini"]
  gem.email         = ["aelhussaini@splinter.me"]
  gem.description   = %q{OmniAuth strategy for goodreads.}
  gem.summary       = %q{OmniAuth strategy for goodreads.}
  gem.homepage      = "https://github.com/sandboxws/omniauth-goodreads"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.name          = "omniauth-goodreads"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Goodreads::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
end
