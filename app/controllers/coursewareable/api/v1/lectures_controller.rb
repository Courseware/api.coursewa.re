module Coursewareable::Api::V1
  # [Coursewareable::Lecture] API controller
  class LecturesController < ApplicationController

    # Ask for an oAuth token first
    doorkeeper_for :index, :show

    # Render current_user lectures
    def index
      lectures = current_resource_owner.lectures

      render :json => lectures
    end

    # Render requested lecture
    def show
      lecture = Coursewareable::Lecture.find(params[:id])

      render :json => lecture
    end
  end
end
