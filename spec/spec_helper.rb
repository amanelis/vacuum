# Simplecov
require 'simplecov'
SimpleCov.start do
  add_group "Controllers",    "app/controllers"
  add_group "Models",         "app/models"
  add_group "Mailers",        "app/mailers"
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Fabrication fixtures
Fabrication.configure do |config|
  fabricator_dir = "spec/fabricators"
end

RSpec.configure do |config|  
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  
  # Render all the Views.
  config.render_views
  
  # Clean up the database
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  # Clean on each
  config.before(:each) do
    DatabaseCleaner.clean
  end  
end