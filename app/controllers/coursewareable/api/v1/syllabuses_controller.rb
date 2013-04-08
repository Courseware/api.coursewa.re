module Coursewareable::Api::V1
  # [Coursewareable::Syllabus] API controller
  class SyllabusesController < ApplicationController

    # Ask for an oAuth token first
    doorkeeper_for :show

    # Render requested syllabus
    def show
      classroom = @current_resource_owner.classrooms.find(params[:classroom_id])
      render :json => classroom.syllabus, :root => :syllabus
    end
  end
end
