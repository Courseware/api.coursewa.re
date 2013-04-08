module Coursewareable::Api::V1
  # [Coursewareable::Lecture] API controller
  class LecturesController < ApplicationController

    # Render current_user lectures
    def index
      lectures = @current_resource_owner.lectures
      render :json => lectures
    end

    # Render requested lecture
    def show
      if params[:classroom_id].blank?
        lecture = @current_resource_owner.lectures.find(params[:id])
      else
        classroom = @current_resource_owner.classrooms.find(
          params[:classroom_id])
        lecture = classroom.lectures.find(params[:id])
      end
      render :json => lecture
    end
  end
end
