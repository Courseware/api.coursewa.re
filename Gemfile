source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails-api'
gem 'active_model_serializers'
gem 'actionmailer'
gem 'coursewareable', :github => 'Courseware/coursewareable'
gem 'delayed_job_active_record'
gem 'doorkeeper'

# Speedup a bit things
gem 'multi_json'
gem 'oj'

group :production do
  gem 'pg'
  gem 'puma'
  gem 'party_foul'
  gem 'rack-cors', :require => 'rack/cors'
end

group :development do
  gem 'sqlite3'
  gem 'cane'
  gem 'yard', :require => false
  gem 'redcarpet', :require => false
  gem 'github-markup', :require => false
  gem 'mina', :require => false, :github => 'nadarei/mina'
  gem 'pry-rails'
  gem 'seedbank', '0.3.0.pre'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'ffaker'
  gem 'fabrication'
  gem 'guard-rspec'
  gem 'rb-inotify'
  gem 'database_cleaner'
  gem 'simplecov', :require => false
end
