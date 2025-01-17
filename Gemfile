# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1.3"

# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"

# Use Puma as the app server
gem "puma", "~> 5.2"

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker"

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# Manage multiple processes i.e. web server and webpack
gem "foreman"

# Canonical meta tag
gem "canonical-rails"

# Sentry
gem "sentry-rails"
gem "sentry-sidekiq"

# Logging
gem "amazing_print", "~> 1.3"
gem "rails_semantic_logger", "4.5.0"

# Thread-safe global state
gem "request_store", "~> 1.5"

# Used to build our forms and style them using govuk-frontend class names
gem "govuk-components"
gem "govuk_design_system_formbuilder"

# Background job processor
gem "sidekiq", "~> 6.2"
gem "sidekiq-cron", "~> 1.1"

# UK postcode parsing and validation for Ruby
gem "uk_postcode"

gem "config", "~> 3.1"

gem "httparty", "~> 0.18"

# Wrap jsonb columns with activemodel-like classes
gem "store_model", "~> 0.9"

gem "pundit"

# DfE Sign-in
gem "omniauth"
gem "omniauth_openid_connect"
gem "omniauth-rails_csrf_protection"

# Full text search
gem "pg_search", "~> 2.3"

gem "slack-notifier"

# Tracking changes to models
gem "audited", "~> 4.9"

# Trainee state and transitions
gem "stateful_enum"

# Pagination
gem "kaminari"

gem "activerecord-session_store"

# End-user application performance monitoring
gem "skylight"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  # GOV.UK interpretation of rubocop for linting Ruby
  gem "erb_lint", require: false
  gem "rubocop-govuk"
  gem "scss_lint-govuk"

  # Debugging
  gem "pry-byebug"

  # Better use of test helpers such as save_and_open_page/screenshot
  gem "launchy"

  # Testing framework
  gem "rspec-rails", "~> 5.0.1"

  gem "rails-controller-testing"

  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 3.35"

  gem "dotenv-rails"

  gem "timecop", "~> 0.9.4"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.6"
  gem "web-console", ">= 3.3.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-commands-rspec", "~> 1.0"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Headless browser testing kit
  gem "cuprite", "~> 0.13"
  gem "webdrivers", "~> 4.6"

  gem "shoulda-matchers", "~> 4.5"
  # Code coverage reporter
  gem "simplecov", "~> 0.21.2", require: false

  # Page objects
  gem "site_prism", "~> 3.7"

  gem "webmock"
end

# Required for example_data so needed in review, qa and pen too
group :development, :test, :review, :qa, :audit do
  gem "factory_bot_rails"
  gem "faker"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
