module Coursewareable::Api::V1
  # [Coursewareable::Assignments] API controller
  class AssignmentsController < ApplicationController

    # Render user assignments
    def index
      assignments = @current_resource_owner.assignments

      render :json => assignments
    end

    # Render requested assignment
    def show
      if params[:classroom_id].blank?
        assignment = @current_resource_owner.assignments.find(params[:id])
      else
        classroom = @current_resource_owner.classrooms.find(
          params[:classroom_id])
        assignment = classroom.assignments.find(params[:id])
      end
      render :json => assignment
    end
  end
end
