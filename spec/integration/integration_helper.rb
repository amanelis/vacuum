require 'spec_helper'
require 'capybara/rspec'
require 'capybara/rails'

RSpec.configure do |config|
  # See: https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  include Warden::Test::Helpers
  Warden.test_mode!

  Capybara.javascript_driver = :webkit
end