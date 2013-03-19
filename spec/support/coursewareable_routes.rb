RSpec.configure do |config|
  # Add support for named routes
  config.include(Rails.application.routes.url_helpers, :type => :controllers)
  # Add support for engine routes
  config.before :type => :controller do
    @routes = Coursewareable::Engine.routes
  end
  config.before :type => :routing do
    @routes = Coursewareable::Engine.routes
  end
end
