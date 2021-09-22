# frozen_string_literal: true

require_relative "lib/sellsy_v2/version"

Gem::Specification.new do |spec|
  spec.name          = "sellsy_v2"
  spec.version       = SellsyV2::VERSION
  spec.authors       = ["Victor Holl"]
  spec.email         = ["v_h@me.com"]

  spec.summary       = "Very simple and basic RESTClient for Sellsy V2 API"
  spec.homepage      = "https://www.vho.fr"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/v-h-z/sellsy_v2"
  spec.metadata["changelog_uri"] = "https://github.com/v-h-z/sellsy_v2/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "json"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
