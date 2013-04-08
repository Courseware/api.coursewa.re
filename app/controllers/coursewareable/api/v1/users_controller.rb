module Coursewareable::Api::V1
  # [Coursewareable::User] API controller
  class UsersController < ApplicationController

    # Handles user profile
    def index
      render :json => current_resource_owner, :root => :user
    end

  end
end
