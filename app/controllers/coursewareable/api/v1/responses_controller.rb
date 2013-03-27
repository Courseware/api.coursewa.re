module Coursewareable::Api::V1
  # [Coursewareable::Response] API controller
  class ResponsesController < ApplicationController

    # Ask for an oAuth token first
    doorkeeper_for :show

    # Render requested reponse
    def show
      responses = Coursewareable::Assignment.find(
        params[:assignment_id]).responses

      render :json => responses
    end
  end
end
