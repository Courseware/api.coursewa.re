module Coursewareable::Api::V1
  # [Coursewareable::Assignments] API controller
  class AssignmentsController < ApplicationController

    # Ask for an oAuth token first
    doorkeeper_for :index, :show


    # Render current_user assignments
    def index
      assignments = current_resource_owner.assignments

      render :json => assignments
    end

    # Render requested assignment
    def show
      assignment = Coursewareable::Assignment.find(params[:id])

      render :json => assignment
    end
  end
end
