module Coursewareable::Api::V1
  # [Coursewareable::Response] API controller
  class ResponsesController < ApplicationController

    # Render requested response
    def show
      resp = current_resource_owner.responses.where(
        :assignment_id => params[:assignment_id]).first
      render :json => resp, :root => :response
    end
  end
end
