require 'spec_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.configure do |config|
  include Warden::Test::Helpers
  include Capybara::DSL
  Warden.test_mode!
  Capybara.javascript_driver = :webkit
end