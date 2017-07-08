require "pry-byebug"

SPEC_ROOT = Pathname(__dir__)
TEST_APP_NAME = "test_app".freeze

Dir[SPEC_ROOT.join("support/*.rb").to_s].each { |f| require f }

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.default_formatter = "doc" if config.files_to_run.one?

  config.profile_examples = 10

  config.order = :random
  Kernel.srand config.seed
end
