module Coursewareable::Api::V1
  # [Coursewareable::Syllabus] API controller
  class SyllabusesController < ApplicationController

    # Ask for an oAuth token first
    doorkeeper_for :show

    # Render requested syllabus
    def show
      syllabus = Coursewareable::Classroom.find(params[:classroom_id]).syllabus

      render :json => syllabus
    end
  end
end
