# frozen_string_literal: true

require "bundler/setup"

require "simplecov"
require "coveralls"

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter "/spec"
end
Coveralls.wear!

require "daino"

require_relative "./support/shared_contexts/with_super_admin_context"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.ignore_localhost = false

  %w(CORTEX_API_KEY CORTEX_SUPER_ADMIN_API_KEY).each do |key|
    config.filter_sensitive_data("<API_KEY>") { key }
  end
  uri = URI(ENV["CORTEX_API_ENDPOINT"])
  config.filter_sensitive_data("<API_ENDPOINT>") { uri.hostname }
end
