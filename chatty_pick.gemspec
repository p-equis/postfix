# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chatty_pick/version'

Gem::Specification.new do |gem|
  gem.name          = "chatty_pick"
  gem.version       = ChattyPick::VERSION
  gem.authors       = ["Paul Phillips"]
  gem.email         = ["nunya"]
  gem.description   = %q{Automatically appends a merge-message when cherry-picking commits across branches.}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
