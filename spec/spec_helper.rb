# frozen_string_literal: true

require 'simplecov'
require 'database_cleaner/active_record'
require './lib/api_faker/api_faker'
require 'zeitwerk'

SimpleCov.start

loader = Zeitwerk::Loader.new
loader.push_dir('./app/')
loader.push_dir('./app/models')
loader.push_dir('./app/services')
loader.push_dir('./lib/api_faker')
loader.setup

DatabaseCleaner.strategy = :truncation

ApiFaker.new.setup_stub
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
