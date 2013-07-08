RSpec.configure do |config|
  # Add support for named routes
  config.include(Rails.application.routes.url_helpers, :type => :controllers)
end
