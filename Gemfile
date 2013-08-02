source 'https://rubygems.org'

# Ruby
ruby '1.9.3'

# Rails
gem 'rails', '3.2.13'

# AWS
gem 'aws-s3', :require => 'aws/s3'

# Database
gem 'bson'
gem 'bson_ext'
gem 'mongo'
gem 'mongoid'

# Other
gem 'haml'
gem 'devise'
gem 'cancan'
gem 'stripe'
gem 'mail_view'
gem 'premailer-rails'
gem 'delayed_job_web'
gem 'devise-encryptable'
gem 'delayed_job_mongoid'
gem 'will_paginate_mongoid'
gem 'exception_notification'

# Assets
group :assets do
  gem 'bourbon',      '>= 3.0.1'
  gem 'coffee-rails'
  gem 'compass-rails'
  gem 'haml-rails'
  gem 'jquery-rails'
  gem 'sass'
  gem 'sass-rails'
  gem 'uglifier'
  gem 'zurb-foundation', '~> 4.0.0'
  gem 'font-awesome-rails'
end

group :production do
  gem 'thin'
end

group :development do
  gem 'foreman'
  gem 'annotate'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'awesome_print'
  gem 'binding_of_caller'
end

group :test, :development do
  gem 'faker'
  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'mongoid-rspec'
  gem 'rspec-expectations'
  gem 'terminal-notifier'
  gem 'debugger'
  gem 'turn', :require => false
end

group :test do
  gem 'launchy'
  gem 'webmock'
  gem 'capybara'
  gem 'simplecov'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end
