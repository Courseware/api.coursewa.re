module Coursewareable::Api::V1
  # [Coursewareable::Syllabus] API controller
  class SyllabusesController < ApplicationController

    # Ask for an oAuth toke first
    doorkeeper_for :show

    # Render requested syllabus
    def show
      syllabus = Coursewareable::Syllabus.find(params[:id])

      render :json => syllabus
    end
  end
end
