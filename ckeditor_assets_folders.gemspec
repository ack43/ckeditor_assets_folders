# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ckeditor_assets_folders/version'

Gem::Specification.new do |spec|
  spec.name          = "ckeditor_assets_folders"
  spec.version       = CkeditorAssetsFolders::VERSION
  spec.authors       = ["Alexander Kiseliev"]
  spec.email         = ["i43ack@gmail.com"]

  spec.summary       = %q{Folder for ckeditor`s upload assets}
  spec.description   = %q{Folder for ckeditor`s upload assets}
  spec.homepage      = "https://github.com/ack43/ckeditor_assets_folders"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"


  spec.add_dependency 'ckeditor', '~> 4.2'
  spec.add_dependency 'mongoid'

  spec.add_dependency 'jquery-dragdrop-rails'

end
