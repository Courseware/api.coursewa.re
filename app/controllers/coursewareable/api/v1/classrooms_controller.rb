module Coursewareable::Api::V1
  # [Coursewareable::Classroom] API controller
  class ClassroomsController < ApplicationController
    doorkeeper_for :index, :show, :collaborators, :timeline

    def index
      @classrooms = Coursewareable::Classroom.all
      render :json => @classrooms
    end

    def show
      @classroom = Coursewareable::Classroom.find(params[:id])
      render :json => @classroom
    end

    def collaborators
      classroom = Coursewareable::Classroom.find(params[:class_id])

    end

    def timeline
      @timeline = Coursewareable::Classroom.find(params[:class_id]).all_activities
      render :json => @timeline
    end
  end
end
