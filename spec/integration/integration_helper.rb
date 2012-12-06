require 'spec_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.configure do |config|
  include Warden::Test::Helpers
  Warden.test_mode!
  Capybara.javascript_driver = :webkit
end