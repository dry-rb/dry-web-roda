require "dry/web/roda/cli"
require "fileutils"

SPEC_ROOT = Pathname(__dir__)
TEST_APP_ROOT = SPEC_ROOT.join("test_app")

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # Will default to `true` in RSpec 4
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Will default to `true` in RSpec 4
    mocks.verify_partial_doubles = true
  end

  # Limit a run to individual examples or groups by tagging them with `:focus`
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # Print slowest examples and example groups at the end of the spec run
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  config.before :suite do
    Dry::Web::Roda::CLI.start ["new", TEST_APP_ROOT.to_s]
  end

  config.after :suite do
    FileUtils.rm_rf TEST_APP_ROOT
  end
end
