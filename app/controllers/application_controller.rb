# Default controller for [Coursewareable] API
class ApplicationController < ActionController::API
  include Sorcery::Controller

  private

  # Return the current_user
  def current_resource_owner
    if doorkeeper_token
      Coursewareable::User.find(doorkeeper_token.resource_owner_id)
    end
  end
end
