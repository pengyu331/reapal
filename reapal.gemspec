# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "reapal/version"

Gem::Specification.new do |spec|
  spec.name          = "reapal"
  spec.version       = Reapal::VERSION
  spec.authors       = ["tony"]
  spec.email         = ["tony@omniaccount.com"]

  spec.summary       = %q{融宝支付的SDK}
  spec.description   = %q{富民银行的存管实现}
  spec.homepage      = "https://github.com/omniaccountcorp/reapal"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'macaddr', '~> 1.7', '>= 1.7.1'
  spec.add_development_dependency 'byebug', '~> 9.1'
  spec.add_development_dependency 'faker', '~> 1.8', '>= 1.8.4'
end
