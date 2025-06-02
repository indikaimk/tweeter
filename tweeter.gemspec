require_relative "lib/tweeter/version"

Gem::Specification.new do |spec|
  spec.name        = "tweeter"
  spec.version     = Tweeter::VERSION
  spec.authors     = [ "cloudqubes" ]
  spec.email       = [ "cloud.qubes@gmail.com" ]
  spec.homepage    = "https://github.com/indikaimk/tweeter"
  spec.summary     = "Rails engine for adding tweeting capability for your Rails 8 app."
  spec.description = "Tweeter is a Rails engine. You can hook it into your Rails 8 app and send tweets."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/indikaimk/tweeter"
  spec.metadata["changelog_uri"] = "https://github.com/indikaimk/tweeterCHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.0.2"
end
