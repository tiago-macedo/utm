# frozen_string_literal: true

require_relative "lib/yatm/version"

Gem::Specification.new do |spec|
  spec.name          = "yatm"
  spec.version       = YATM::VERSION
  spec.authors       = ["tiago-macedo"]
  spec.email         = ["tiagomacedo@ufrj.br"]

  spec.summary       = "Yet Another Turing Machine implementation."
  spec.description   = "Yes, it is yet another Turing Machine implementation."
  spec.homepage      = "https://github.com/tiago-macedo/yatm"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tiago-macedo/yatm"
  spec.metadata["changelog_uri"] = "https://github.com/tiago-macedo/yatm"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = [
		"lib/yatm.rb",
		"lib/yatm/version.rb",
		"lib/yatm/error.rb",
		"lib/yatm/tape/tape.rb",
		"lib/yatm/state_machine/state_machine.rb"
	]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
