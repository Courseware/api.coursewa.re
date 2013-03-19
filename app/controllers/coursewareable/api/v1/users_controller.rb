module Coursewareable::Api::V1
  # [Coursewareable::User] API controller
  class UsersController < ApplicationController

    # Ask for an oAuth token first
    doorkeeper_for :me

    # Handles user profile
    def me
      render :json => current_user
    end

  end
end
