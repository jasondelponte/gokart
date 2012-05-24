# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gokart/version"

Gem::Specification.new do |s|
  s.name        = "gokart"
  s.version     = Gokart::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Del Ponte"]
  s.email       = ["info@jasondelponte.com"]
  s.homepage    = "https://github.com/jasondelponte/gokart"
  s.summary     = %q{Utility to build a development environment for building Golang webaps using rake and sprockets.}
  s.description = %q{Combination of tooks which will make developing webapps using go easier.  The gokart gem by default combines SASS, Coffee Script, Rake, and Sprokets with Go to provide a great development environment.  This environment supports test driven development (TDD) with ruby guard and jasmine.}

  s.rubyforge_project = "gokart"

  s.files         = Dir["README.md", "LICENSE", "lib/**/*.rb", "assets/**/*"]
  s.executables   = ["gokart"]
  s.require_paths = ["lib"]

  s.add_development_dependency("sass")
  s.add_development_dependency("coffee-script")
  s.add_development_dependency("therubyracer")
  s.add_development_dependency("sprockets")
  s.add_development_dependency("guard")
  s.add_development_dependency("guard-coffeescript")
  s.add_development_dependency("guard-jasmine")
  s.add_development_dependency("guard-sass")
  s.add_development_dependency("guard-rake")
  s.add_development_dependency("guard-livereload")
  s.add_development_dependency("guard-shell")
  s.add_development_dependency("jasmine")
  s.add_development_dependency("yui-compressor")
  s.add_development_dependency("uglifier")

  s.add_dependency("bundler", ">= 1.0.0")
end
