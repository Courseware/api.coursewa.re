module Coursewareable::Api::V1
  # [Coursewareable::Classroom] API controller
  class ClassroomsController < ApplicationController

    # Lists available classrooms
    def index
      classrooms = current_resource_owner.classrooms
      render :json => classrooms
    end

    # Lists classroom details
    def show
      classroom = current_resource_owner.classrooms.find(params[:id])
      render :json => classroom
    end

    # Render the classrooms collaborators
    def collaborators
      classroom = current_resource_owner.classrooms.find(params[:classroom_id])
      render :json => classroom.collaborators, :root => :collaborators
    end

    # Render the timeline of classroom
    def timeline
      classroom = current_resource_owner.classrooms.find(params[:classroom_id])
      activities = classroom.all_activities.limit(
        params[:limit]).offset(params[:offset])
      render :json => activities, :root => :activities, :each_serializer => Coursewareable::ActivitySerializer
    end
  end
end
