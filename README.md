The Courseware Project API / api.coursewa.re
============================================

This is a Rails app to provide an oAuth v2 enabled API endpoint for an
existing Coursewa.re instance.

The API responds just JSON.

# Installation

1. Close the repository
2. Run `bundle install`
3. Run migrations `bundle exec rake db:create db:migrate db:test:prepare`
4. Run `rails s`

Please run `bundle exec rake routes` in order to see the available endpoints.

# Testing

Run `bundle exec rake` to run tests.
