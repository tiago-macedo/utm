# frozen_string_literal: true

require_relative "lib/yatm/version"

Gem::Specification.new do |spec|
  spec.name          = "yatm"
  spec.version       = YATM::VERSION
  spec.authors       = ["tiago-macedo"]
  spec.email         = ["tiagomacedo@ufrj.br"]

  spec.summary       = "Yet Another Turing Machine implementation."
  spec.description   = <<~DESC.chomp
    This gem provides you with the module `YATM`.
    The class YATM::Machine, specifically, allows you to program a functioning
    turing machine and load it with a tape containing arbitrary symbols.
    
    Check out files `lib/example_*.rb` to see it in action.
  DESC
  spec.homepage      = "https://github.com/tiago-macedo/yatm"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

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
    "lib/yatm/state_machine/state_machine.rb",
    "lib/yatm/machine/machine.rb"
  ]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
