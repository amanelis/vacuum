require 'spec_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Capybara::DSL
  Warden.test_mode!
  Capybara.javascript_driver = :webkit
end
