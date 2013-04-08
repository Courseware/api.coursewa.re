module Coursewareable::Api::V1
  # Default controller for [Coursewareable] API v1
  class ApplicationController < ::ApplicationController
    before_filter :set_resource_owner

    # Require an OAuth token for API resources
    doorkeeper_for :all

    protected

    # Loads user owning the access token
    def set_resource_owner
      if doorkeeper_token and doorkeeper_token.accessible?
        @current_resource_owner = ::Coursewareable::User.find(
          doorkeeper_token.resource_owner_id)
      end
    end
  end
end
