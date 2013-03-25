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
      timeline = Coursewareable::Classroom.find(params[:classroom_id]).all_activities

      # Paginate the timeline
      timeline = ::Kaminari.paginate_array(timeline).page(params[:page])
      timeline = timeline.per(params[:limit]).offset(params[:offset])
      render :json => timeline
    end

    private

    # Return the current_user
    def current_resource_owner
      if doorkeeper_token
        Coursewareable::User.find(doorkeeper_token.resource_owner_id)
      end
    end
  end
end
