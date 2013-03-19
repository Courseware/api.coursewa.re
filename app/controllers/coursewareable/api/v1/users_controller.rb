module Coursewareable::Api::V1
  class UsersController < ApplicationController

    # Ask for an oAuth token first
    doorkeeper_for :me

    # Handles user profile
    def me
      render :json => current_user
    end

  end
end
