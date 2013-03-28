module Coursewareable::Api::V1
  # Default controller for [Coursewareable] API v1
  class ApplicationController < ::ApplicationController

    # Require an OAuth token for API resources
    doorkeeper_for :all

    private

    # Loads user owning the access token
    def current_resource_owner
      ::Coursewareable::User.find(
        doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
  end
end
