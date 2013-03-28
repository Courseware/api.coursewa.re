module Coursewareable::Api::V1
  # [Coursewareable::Classroom] API controller
  class ClassroomsController < ApplicationController
    doorkeeper_for :index, :show, :collaborators, :timeline

    def index
      classrooms = current_resource_owner.classrooms
      render :json => classrooms
    end

    def show
      classroom = Coursewareable::Classroom.find(params[:id])
      render :json => classroom
    end

    # Render the collaborators of a specified classroom
    # This method is the same as #show, but this render just collaborations
    def collaborators
      # @collaborators includes owner and collaborations
      classroom = Coursewareable::Classroom.find(params[:classroom_id])
      classroom[:include_collaborations] = true
      render :json => classroom
    end

    # Render the timeline of classroom
    def timeline
      classroom = Coursewareable::Classroom.find(params[:classroom_id])

      # Paginate the timeline
      timeline = classroom.all_activities.limit(params[:limit]).offset(params[:offset])

      render :json => timeline
    end
  end
end
