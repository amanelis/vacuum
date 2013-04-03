source 'https://rubygems.org'

# Ruby
ruby '1.9.3'

# Rails
gem 'rails', '3.2.11'

# Database
gem 'bson'
gem 'bson_ext'
gem 'mongoid'

# Other
gem 'haml'
gem 'devise'
gem 'zurb-rush'
gem 'will_paginate_mongoid'

# Assets
group :assets do
  gem 'bourbon',      '>= 3.0.1'
  gem 'coffee-rails'
  gem 'compass-rails'
  gem 'haml-rails'
  gem 'jquery-rails'
  gem 'sass',         '~> 3.2.0.alpha.95'
  gem 'sass-rails',   '~> 3.2.0.alpha.95'
  gem 'uglifier'
  gem 'zurb-foundation'
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
  gem 'rack-mini-profiler'
end

group :test, :development do
  gem 'faker'
  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'rspec-expectations'
  gem 'terminal-notifier'
  gem 'debugger'
  gem 'turn', :require => false
end

group :test do
  gem 'minitest'
  gem 'launchy'
  gem 'webmock'
  gem 'capybara'
  gem 'simplecov'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end
