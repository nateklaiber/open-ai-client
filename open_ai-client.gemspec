# frozen_string_literal: true

require_relative "lib/open_ai/client/version"

Gem::Specification.new do |spec|
  spec.name = "open_ai-client"
  spec.version = OpenAi::Client::VERSION
  spec.authors = ["Nate Klaiber"]
  spec.email = ["nate@deviceindependent.com.com"]

  spec.summary = "Client to interact with the OpenAI Platform"
  spec.description = "Client to interact with the OpenAI Platform"
  spec.homepage = "https://github.com/nateklaiber/open-ai-client.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nateklaiber/open-ai-client.git"
  spec.metadata["changelog_uri"] = "https://github.com/nateklaiber/open-ai-client/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency('faraday')
  spec.add_dependency('mimemagic')
  spec.add_dependency('chronic')
  spec.add_dependency('ruby-units')
  spec.add_dependency('mime-types')
  spec.add_dependency('faraday_middleware')
  spec.add_dependency('multi_json')
  spec.add_dependency('dotenv')
  spec.add_dependency('addressable')
  spec.add_dependency('restless_router')
  spec.add_dependency("terminal-table")
  spec.add_dependency("liquid")

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
