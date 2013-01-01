source 'https://rubygems.org'

# Freeze ruby version
ruby '1.9.3'

gem 'rails', '3.2.9'
gem 'thin'

# Backbone
gem 'backbone-on-rails'

# Facebook open-graph
gem 'koala'

group :production do
  # DB Driver
  gem 'pg'
end

group :development do
  gem 'better_errors'
end

group :test, :development do
  # DB Driver
  gem 'sqlite3'

  # Test suite
  gem 'minitest'
  gem 'minitest-matchers'
  gem 'minitest-metadata', require: false

  gem 'minitest-rails'
  gem 'minitest-rails-shoulda'
  gem 'minitest-rails-capybara'

  gem 'mocha', '>= 0.13.1', require: false
  gem 'capybara'

  gem 'database_cleaner'

  # Test javascript headlessly
  # Using a poltergeist fork as the current release dos not support capybara 2.0
  gem 'poltergeist', git: 'https://github.com/brutuscat/poltergeist'

  # Enhanced test display
  gem 'turn'

  # Code coverage
  gem 'simplecov', require: false

  # Awesome outputs on STDOUT
  require 'awesome_print'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'handlebars-rails', git: 'https://github.com/svenfuchs/handlebars-rails.git'

  gem 'sass-rails', '~> 3.2.3'
  gem 'uglifier',   '>= 1.0.3'
end

gem 'jquery-rails'

# To use Jbuilder templates for JSON
# gem 'jbuilder'
