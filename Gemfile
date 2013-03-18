source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails-api'
gem 'actionmailer'
gem 'coursewareable', :git => 'https://5a46b48f3664e53f78b41d5cdbfe3b31a2d82b4d:x-oauth-basic@github.com/stas/coursewareable.git'
gem 'delayed_job_active_record'

# Speedup a bit things
gem 'multi_json'
gem 'oj'

group :production do
  gem 'pg'
  gem 'puma'
  gem 'party_foul'
end

group :development do
  gem 'sqlite3'
  gem 'cane'
  gem 'yard', :require => false
  gem 'mina', :require => false
  gem 'pry-rails'
end

group :development, :test do
  gem 'rspec-rails', '2.12.0'
  gem 'ffaker'
  gem 'fabrication'
  gem 'guard-rspec'
  gem 'rb-inotify'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'simplecov', :require => false
end
