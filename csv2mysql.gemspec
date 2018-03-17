# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv2mysql/version"

Gem::Specification.new do |spec|
  spec.name          = "csv2mysql"
  spec.version       = Csv2mysql::VERSION
  spec.authors       = ["hirapi"]
  spec.email         = ["hirapi.chmv71@gmail.com"]

  spec.summary       = %q{A CLI tool that generates INSERT | UPDATE query from CSV file.}
  spec.description   = %q{You can use csv2mysql when you should create or update records with data in a CSV file.}
  spec.homepage      = "https://github.com/hirapi/csv2mysql"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = "csv2mysql"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "thor"
end
